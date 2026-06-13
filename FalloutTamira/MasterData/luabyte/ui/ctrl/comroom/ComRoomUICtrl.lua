local ComRoomUICtrl = BaseClass("ComRoomUICtrl", BaseUICtrl)
local M = ComRoomUICtrl

function M:Init()
    -- 通讯
    self._view.imgCom:onPolygonClick(function(go)
        -- ComRoomDataMgr:GetInstance():GetHeroStoryData(true)
    end)

    -- 长官笔记
    self._view.imgChiefNote:onPolygonClick(function(go)
        UIContextMgr:GetInstance():Show("ChiefNoteUI")
    end)

    -- 剧情图鉴
    self._view.imgStoryAtlas:onPolygonClick(function(go)
        if self:_CheckOpenCondition(23) then
            UIContextMgr:GetInstance():Show("PlotReviewUI")
        end
    end)

    -- 百科图鉴
    self._view.imgEncycAtlas:onPolygonClick(function(go)
        if self:_CheckOpenCondition(22) then
            UIContextMgr:GetInstance():Show("PlotAtlasUI")
        end
    end)

    -- 调查任务
    self._view.imgSurveyTask:onPolygonClick(function(go)
        GameHelper.TipsById(30179)
        -- if self:_CheckOpenCondition(20) then
        --     UIContextMgr:GetInstance():Show("WishjourneyUI")
        -- end
    end)

    -- 战员图鉴
    self._view.imgHeroAtlas:onPolygonClick(function(go)
        if not PlotAtlasDataMgr:GetInstance():IsInitHero() then return end
        UIContextMgr:GetInstance():Show("HeroAtlasUI")
    end)
end

function M:OnEnter()
    GameHelper.DoPlayerAction(PlayerAction.OpenMessage)
    EventMgr:Broadcast(UIMessageNames.OTAKU_VOICE_CHANGEBGM, 1)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

-- 检查系统开放条件
function M:_CheckOpenCondition(openId)
    local openCfg = ConfigHelper.GetCfgByLua("functionOpen", openId)

    for _, unlockId in ipairs(openCfg.openCondition) do
        local unlock = GameHelper.CheckLockByOpenConditionId(unlockId)

        if unlock == false then
            local openCondCfg = ConfigHelper.GetCfgByLua("openCondition", unlockId)
            GameHelper.Tips(ConfigHelper.GetLocalString(openCondCfg.tips))
            return false
        end
    end
    return true
end

function M:OnVisible()
    RedPointMgr:ForceCheck(22)
end

function M:OnClose()
end

function M:OnDispose()
    EventMgr:Broadcast(UIMessageNames.OTAKU_VOICE_CHANGEBGM, 0)
    M.super.OnDispose(self)
end

return ComRoomUICtrl
