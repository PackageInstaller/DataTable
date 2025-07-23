-- @FileName:   SandPlayHappyFarmFieldItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-09-05 10:32:34
-- @Copyright:   (LY) 2024 锚点降临

module("game.sandPlay.view.SandPlayHappyFarmFieldItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTextNum = self:getChildGO("mTextNum"):GetComponent(ty.Text)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mClick"), function()
        if self:getData().type == 1 then
            local field_id = nil
            local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
            if playThing then
                field_id = playThing:getField_Id()
            end

            if field_id == nil then
                gs.Message.Show(_TT(137031))
                return
            end

            if self.data.propsVo.count > 0 then
                local fieldThing = nil
                local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
                for _, thing in pairs(npcThingList) do
                    if thing.mData.config.base_config.type == SandPlayConst.NPC_TYPE.FIELD and thing:getFieldId() == field_id then
                        fieldThing = thing
                        break
                    end
                end

                if fieldThing then
                    local finishCall = function ()
                        local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
                        playThing:addWeapon("arts/character/scene_module/nongchang/nc_sashuihu/modelnc_sashuihu.prefab", 1, false, function ()
                            local act = SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_BZ

                            local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[act]
                            local frameCount = playThing:GetTotalFrameCount(aniName)
                            if frameCount > 0 then
                                playThing:addFrameCallEvent(aniName, function ()
                                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = field_id, params = {2, self.data.seed_id}})

                                    playThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.STAND)
                                    playThing:removeWeapon()
                                end, frameCount - 1)
                            end

                            playThing:setActionState(act)
                            playThing:addEffect("arts/fx/3d/sceneModule/dx_101/fx_farm_bozhong.prefab", 10, playThing.mModel.m_points[fight.FightDef.POINT_RWEAPON])
                        end)
                    end

                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = fieldThing:getPosition(), finishCall = finishCall})
                    GameDispatcher:dispatchEvent(EventName.CLOSE_SANDPLAY_HAPPYFARM_FIELD)
                end
            else
                gs.Message.Show(_TT(137030))
            end
        else
            local rect = self.UIObject:GetComponent(ty.RectTransform)
            TipsFactory:propsTips({propsVo = self.data.propsVo, isShowUseBtn = false}, {rectTransform = rect})
        end
    end)
end

function setData(self, data)
    super.setData(self, data)

    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.data.propsVo.tid), false)

    self.mTextNum.text = data.propsVo.count
    self.mTextName.text = data.propsVo.name

end

return _M
