-- @FileName:   SandPlayHappyFarmBreedPanel.lua
-- @Description:  开心农场养殖界面
-- @Author: ZDH
-- @Date:   2024-01-17 11:40:13
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayHappyFarmBreedPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayHappyFarmBreedPanel.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isShowMoneyBar = 1

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 519)
    self:setTxtTitle(_TT(137012))
end

-- 初始化数据
function initData(self)
    super.initData(self)

end

--初始化UI
function configUI(self)
    self.mGoodsItem = self:getChildGO("mGoodsItem")
    self.mGoodsContent = self:getChildTrans("mGoodsContent")

    self.mTextGoodsTime = self:getChildGO("mTextGoodsTime"):GetComponent(ty.Text)
    self.mTextGoodsOut = self:getChildGO("mTextGoodsOut"):GetComponent(ty.Text)
    self.mTextGoodsDesc = self:getChildGO("mTextGoodsDesc"):GetComponent(ty.Text)

    self.mTextCountLimit = self:getChildGO("mTextCountLimit"):GetComponent(ty.Text)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)

    self.mBreedItem = self:getChildGO("mBreedItem")
    self.mBreedContent = self:getChildTrans("mBreedContent")

    self.mBtnBuy = self:getChildGO("mBtnBuy")
end

function initViewText(self)
    self.mText_1.text = _TT(137010)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuy)
end

function onClickBuy(self)
    local fieldId = nil
    for _, field_id in pairs(self.mFieldIdList) do
        local fieldInfo = sandPlay.SandPlayManager:getHappyFarmEventInfo(field_id)
        if fieldInfo == nil or fieldInfo.seed_id == 0 then
            fieldId = field_id
            break
        end
    end

    if fieldId == nil then
        gs.Message.Show(_TT(137028))
        return
    end

    if self.mSelectSeedConfigVo then
        if not MoneyUtil.judgeNeedMoneyCountByTid(self.mSelectSeedConfigVo.cost[1], self.mSelectSeedConfigVo.cost[2]) then
            return
        end
    end

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = fieldId, params = {1, self.mSelectSeedConfigVo.id}})
end

--激活
function active(self, args)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.refreshView, self)

    MoneyManager:setMoneyTidList({MoneyTid.HAPPYFARM_TID})

    self.mFieldIdList = args
    self.mMaxCount = table.nums(args)
    self:refreshView()
end

--非激活
function deActive(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.refreshView, self)

    MoneyManager:setMoneyTidList()

    self:clearSeedItem()
    self:clearFieldItem()

    self.mSelectIndex = nil
    self.mSelectSeedConfigVo = nil
end

function refreshView(self)
    local fieldDic = sandPlay.SandPlayManager:getHappyFarmEventInfoDic()
    local fieldCount = 0

    local fieldList = {}
    for _, fieldInfo in pairs(fieldDic) do
        if fieldInfo.configVo and fieldInfo.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Poultry then
            table.insert(fieldList, fieldInfo)

            fieldCount = fieldCount + 1
        end
    end

    table.sort(fieldList, function (a, b)
        return a.grow_time < b.grow_time
    end)

    self:clearFieldItem()
    for _, fieldData in pairs(fieldList) do
        local fieldItem = SimpleInsItem:create(self.mBreedItem, self.mBreedContent, "sandPlay_HappyFarm_fieldItem")
        table.insert(self.mFieldItemList, fieldItem)

        fieldItem:getChildGO("mTextName"):GetComponent(ty.Text).text = fieldData.configVo:getName()
        fieldItem:addUIEvent(nil, function ()
            if fieldData.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then --(鸡)
                local poultryReapThing = nil
                local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
                for _, thing in pairs(npcThingList) do
                    if thing.mData.config.base_config.type == SandPlayConst.NPC_TYPE.POULTRYREAP then
                        poultryReapThing = thing
                        break
                    end
                end

                if not poultryReapThing then
                    logError("没有鸡蛋一键收获的NPC")
                    return
                end

                GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = poultryReapThing:getPosition(), stopDistance = 0.5})
                self:close()
            elseif fieldData.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Sheep then --（羊）
                local breedThing = nil
                local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
                for _, thing in pairs(npcThingList) do
                    if thing.mData.config.base_config.type == SandPlayConst.NPC_TYPE.BREED then
                        breedThing = thing
                        break
                    end
                end

                if breedThing then
                    local sheepThing = nil
                    local poultyThingList = breedThing:getPoultryThingList(SandPlayConst.HappyFarm_Poultry_Type.Sheep)
                    for _, thing in pairs(poultyThingList) do
                        if thing.mData.field_id == fieldData.field_id then
                            sheepThing = thing
                            break
                        end
                    end

                    if sheepThing then
                        sheepThing:stopAI()

                        GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = sheepThing:getPosition(), stopDistance = 0.5, pauseCall = function ()
                            sheepThing:startAI()
                        end, })
                        self:close()
                    end
                end

            end
        end)

        fieldItem.refreshTime = function ()
            local growDt = GameManager:getClientTime() - fieldData.grow_time --成长时间

            local timeStr = ""
            local canGet = true
            if fieldData.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then --(鸡)不需要等待收获即可成熟
                local get_interval = fieldData.configVo.production_cycle[1] --收割间隔
                local grow_interval = fieldData.configVo.ripe_time[1] --成长间隔

                local canGetCount = 0 --可收获次数
                local grow_dt = growDt - grow_interval
                if grow_dt >= 0 then
                    canGetCount = math.floor(grow_dt / get_interval)
                end

                if canGetCount <= fieldData.reap_num then
                    canGet = false

                    local nextGetDt = ((canGetCount + 1) * get_interval) + grow_interval --可收获次数+1*收获的间隔 + 成长间隔 = 下一次收获的时间
                    local time = nextGetDt - growDt
                    if time > 0 then
                        timeStr = _TT(137025, TimeUtil.getFormatTimeBySeconds_1(time))
                    end
                end
            elseif fieldData.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Sheep then --（羊）需要等待收获才可以继续成长
                local reapDt = fieldData.configVo.production_cycle[1]
                if fieldData.reap_num == 0 then
                    reapDt = reapDt + fieldData.configVo.ripe_time[1]
                end

                local time = reapDt - growDt
                if time > 0 then
                    timeStr = _TT(137025, TimeUtil.getFormatTimeBySeconds_1(time))
                    canGet = false
                end
            end

            fieldItem:getChildGO("mBtnGo"):SetActive(canGet)
            fieldItem:getChildGO("mTextState"):GetComponent(ty.Text).text = timeStr
        end

        fieldItem.refreshTime()
    end

    self.mTextCountLimit.text = _TT(137011, fieldCount, self.mMaxCount)

    local fristSeedId = 999999

    self:clearSeedItem()
    local seedConfigList = sandPlay.SandPlayManager:getHappyFarmSeedConfigVoListByType(SandPlayConst.HappyFarm_Seed_Type.Poultry)
    for seed_id, seedConfigVo in pairs(seedConfigList) do
        local seedItem = SimpleInsItem:create(self.mGoodsItem, self.mGoodsContent, "sandPlay_HappyFarm_seedItem")
        self.mSeedItemList[seed_id] = seedItem

        seedItem:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(seedConfigVo:getIcon())
        seedItem:getChildGO("mTextName"):GetComponent(ty.Text).text = seedConfigVo:getName()
        seedItem:getChildGO("mImgPrice"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(seedConfigVo.cost[1]))
        seedItem:getChildGO("mTextPrice"):GetComponent(ty.Text).text = seedConfigVo.cost[2]

        seedItem:getChildGO("mSelect"):SetActive(false)

        seedItem.select = function ()
            self:onSeedSelect(seedConfigVo)
        end

        seedItem:addUIEvent(nil, function ()
            self:onSeedSelect(seedConfigVo)
        end)

        if seed_id < fristSeedId then
            fristSeedId = seed_id
        end
    end

    local select_id = self.mSelectSeedConfigVo ~= nil and self.mSelectSeedConfigVo.id or fristSeedId
    self.mSeedItemList[select_id].select()

    self:refreshFieldItemTimeShow()
end

function refreshFieldItemTimeShow(self)
    self:clearTimeSn()

    if table.empty(self.mFieldItemList) then
        return
    end

    self.mRefreshFieldTimeSn = self:addTimer(1, 0, self.onRefreshFieldItemTimeShow)
end

function onRefreshFieldItemTimeShow(self)
    for _, fieldItem in pairs(self.mFieldItemList) do
        fieldItem.refreshTime()
    end
end

function onSeedSelect(self, seedConfigVo)
    for _seed_id, seedItem in pairs(self.mSeedItemList) do
        seedItem:getChildGO("mSelect"):SetActive(_seed_id == seedConfigVo.id)
    end

    self.mTextGoodsTime.text = _TT(137009) .. TimeUtil.getHMSByTime(seedConfigVo.ripe_time[1])

    self.mTextGoodsOut.text = _TT(137007) .. _TT(seedConfigVo.produce_des)

    self.mTextGoodsDesc.text = _TT(137008) .. seedConfigVo:getDesc()

    self.mSelectSeedConfigVo = seedConfigVo
end

function clearTimeSn(self)
    if self.mRefreshFieldTimeSn then
        self:removeTimerByIndex(self.mRefreshFieldTimeSn)
        self.mRefreshFieldTimeSn = nil
    end
end

function clearSeedItem(self)
    if self.mSeedItemList then
        for _, item in pairs(self.mSeedItemList) do
            item:poolRecover()
        end
    end

    self.mSeedItemList = {}
end

function clearFieldItem(self)
    if self.mFieldItemList then
        for _, item in pairs(self.mFieldItemList) do
            item:poolRecover()
        end
    end

    self.mFieldItemList = {}
end

return _M
