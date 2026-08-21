-- @FileName:   SandPlayPlayerModel.lua
-- @Description:   沙盒玩法模型基类
-- @Author: ZDH
-- @Date:   2023-07-25 15:35:17
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.model.SandPlayPlayerModel', Class.impl(model.modelLive))

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, nil, sorceId)

    if self.m_ani then
        self.m_ani:LoadAsynAniNameArray(SandPlayConst.HERO_ACT_LIST, finishCall)
    else
        if finishCall then
            finishCall(false, self)
        end
    end
end

function playAction(self, aniName)
    if not self.m_ani then return end

    local aniHash = gs.Animator.StringToHash(aniName)
    if not self.m_ani:IsPlayingShortNameHash(aniHash) then
        self.m_ani:PlayHash(aniHash, function()
            for _, weapon in ipairs(self.m_weaponList) do
                weapon:playAction(aniHash)
            end
            for _, liveAssembly in ipairs(self.m_assemblylist) do
                liveAssembly:playAction(aniHash)
            end
        end)
    end
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    self.m_assemblyPathDic[prefabPath] = false
    self.m_actShowItems[prefabPath] = true

    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    local liveAssembly = model.modelItem.new()
    table.insert(self.m_assemblylist, liveAssembly)

    local function _resultCall(beSucss)
        if beSucss then
            liveAssembly.m_ani:LoadAnimatCtrlSameClip(self.m_ani)

            if finishCall then
                finishCall(liveAssembly)
            end
        else
            self:removeAssembly(prefabPath)
        end
    end

    liveAssembly:setToParent(self.m_points[fight.FightDef.POINT_ROOT])
    liveAssembly:setVisible(self.m_isVisible)
    liveAssembly:setupPrefab(prefabPath, beAlwayEft, _resultCall, 5)
end

-- function setPosition(self, lpos)
--     if self.m_trans and lpos and not table.empty(lpos) then
--         gs.TransQuick:Pos(self.m_trans, lpos.x, lpos.y, lpos.z)
--     end
-- end

function addFrameCallEvent(self, acitonName, callback, frameCount)
    if not self.m_ani then
        logError("annimaCtrl is null")
        return
    end
    self.m_ani:AddFrameCallEvent(acitonName, callback, frameCount)
end

return _M
