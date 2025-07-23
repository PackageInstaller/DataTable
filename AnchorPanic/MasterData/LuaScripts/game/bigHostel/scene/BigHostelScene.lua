-- @FileName:   BigHostelScene.lua
-- @Description:   大宿舍
-- @Author: ZDH
-- @Date:   2025-04-21 17:35:49
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.scene.BigHostelScene', Class.impl())

function ctor(self)

end

function setup(self, finishCall)
    if self.m_model == nil then

        local model_data = bigHostel.BigHostelManager:getHostelHero()
        local model_class = require("game/bigHostel/manager/model/BigHostel_Model_" .. model_data.model_id)

        local function loadFinishCall()
            if model_data.main_type == BigHostelConst.SceneUI_Type.MIANUI then
                GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_UI)
                GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_BIGHOSTEL_SCENEUI, {main_type = model_data.main_type})
                GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Start)
            end

            local data = fashion.FashionManager:getModelHarData(model_data.model_id)
            if (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious()) and data then
                -- 替换材质球预览
                self.mHarFrameSn = LoopManager:addFrame(1, 1, self, function()
                    self.m_model:setMaterial(data.pos, data.materials, {})
                end)
            end

            if finishCall then
                finishCall()
            end
        end

        self.m_model = model_class:new()
        self.m_model:setPrefab(model_data, loadFinishCall)

        bigHostel.BigHostelManager:setSceneModel(self.m_model)
    end
end

function getSceneModel(self)
    return self.m_model
end

-- 重置场景
function reset(self)
    if self.m_model then
        self.m_model:destroy()
        self.m_model = nil
    end

    bigHostel.BigHostelManager:setSceneModel(nil)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
