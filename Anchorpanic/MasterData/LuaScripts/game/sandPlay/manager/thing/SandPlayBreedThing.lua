-- @FileName:   SandPlayBreedThing.lua
-- @Description:   养殖NPC
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayBreedThing', Class.impl(sandPlay.SandPlayRoleNPCThing))

function resetData(self)
    super.resetData(self)

    self.mPoultryThingDic = {}

    self.mPoultryAIInfoDic = {}

    local poultrySeedConfigVoList = sandPlay.SandPlayManager:getHappyFarmSeedConfigVoListByType(SandPlayConst.HappyFarm_Seed_Type.Poultry)
    for seed_id, seedConfigVo in pairs(poultrySeedConfigVoList) do
        local posList = self.mPoultryAIInfoDic[seedConfigVo.subtype]
        if posList == nil then
            posList = {}
        end

        for index, pos in pairs(seedConfigVo.ai_params[1]) do
            posList[index] =
            {
                pos = {x = pos[1], y = pos[2], z = pos[3]},
                index = index,
                occupy = false,
            }
        end
        self.mPoultryAIInfoDic[seedConfigVo.subtype] = posList
    end
end

function createModel(self)
    super.createModel(self)
    self:addEventListener()
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.checkHappyFarmPoultry, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.checkHappyFarmPoultry, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.checkHappyFarmPoultry, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.checkHappyFarmPoultry, self)

end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    self:checkHappyFarmPoultry()
end

function getAIFindPoint(self, subType)
    local AIPosInfo = self.mPoultryAIInfoDic[subType]
    if AIPosInfo then
        local player_pos = gs.VEC3_ZERO
        local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
        if playThing then
            player_pos = playThing:getPosition()
        end

        local posList = {}
        for k, posInfo in pairs(AIPosInfo) do
            if not posInfo.occupy and math.abs(gs.Vector3.Distance(posInfo.pos, player_pos)) > 1 then
                table.insert(posList, posInfo)
            end
        end

        if table.empty(posList) then
            return
            {
                pos = {x = 0, y = 0, z = 0},
                index = 0,
                occupy = false,
            }
        end

        local random_index = math.random(1, #posList)
        local posInfo = posList[random_index]
        posInfo.occupy = true
        return posInfo
    end
end

function revertAIFindPoint(self, point)
    point.occupy = false
end

--检测更新开心农场家禽
function checkHappyFarmPoultry(self)
    local fieldDic = sandPlay.SandPlayManager:getHappyFarmEventInfoDic()

    local breadDataDic = {}
    for _, fieldInfo in pairs(fieldDic) do
        if fieldInfo.configVo and fieldInfo.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Poultry then
            breadDataDic[fieldInfo.field_id] = fieldInfo
        end
    end

    --移除旧家禽
    if self.mPoultryThingDic then
        local clearFieldIdList = {}
        for field_id, thing in pairs(self.mPoultryThingDic) do
            if breadDataDic[field_id] == nil then
                self.mPoultryThingDic[field_id]:recover()
                self.mPoultryThingDic[field_id] = nil
            end
        end
    end

    if table.empty(breadDataDic) then
        return
    end

    --添加新增家禽
    for field_id, field_data in pairs(breadDataDic) do
        local thing = self.mPoultryThingDic[field_id]

        if thing == nil then
            if field_data.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then
                thing = sandPlay.SandPlayChickenThing:create(self)

            elseif field_data.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Sheep then
                thing = sandPlay.SandPlaySheepThing:create(self)
            end
            self.mPoultryThingDic[field_id] = thing
        end

        thing:setData(field_data, self)
    end
end

function getPoultryThingList(self, subType)
    local thingList = {}
    for field_id, thing in pairs(self.mPoultryThingDic) do
        if thing.mData.configVo.subtype == subType then
            table.insert(thingList, thing)
        end
    end

    return thingList
end

function recover(self)
    super.recover(self)

    for _, thing in pairs(self.mPoultryThingDic) do
        thing:recover()
    end
    self.mPoultryThingDic = nil

    self:removeEventListener()
end

return _M
