--[[
-----------------------------------------------------
   @CreateTime:2024/12/24 15:18:45
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:dna培养主界面帧动画处理类
]]

module("game.dna.view.DnaFrameAniCtrl", Class.impl())

function initData(self)
    self.isInit = false
end

function initUiRef(self, isActive, mNodeFrameAniPrefab)
    self.mNodeFrameAniPrefab = isActive and mNodeFrameAniPrefab or nil
end

function active(self)
    self:initData()
end

function deActive(self)
    self:initUiRef()
    self:initData()
    self:recoverPrefab()
end

function recoverPrefab(self)
    if self.m_go then
        gs.GOPoolMgr:RecoverOther(self.goPoolName, self.m_go)
        self.mAnimator = nil
        self.m_go = nil
        self.isInit = false
    end
end

function SetActive(self, isActive)
    if not isActive then
        self:recoverPrefab()
    end
end

function refreshRole(self, prefabUrl, tid)
    self:recoverPrefab()
    self.goPoolName = prefabUrl
    self.tid = tid
    self.m_go = gs.ResMgr:LoadGO(prefabUrl)
    if not self.m_go then
        logError("获取帧动画资源错误，路径：" .. tostring(prefabUrl))
        return
    end
    gs.TransQuick:SetParentOrg(self.m_go.transform, self.mNodeFrameAniPrefab)
    self.mAnimator = self.m_go:GetComponent(ty.Animator)
    self.isInit = true
end

local format_str = "dna_frame_ani_%s_show_%s"
function playAni(self, ttype)
    if not self.isInit then
        return
    end
    AudioManager:playSoundEffect(UrlManager:getDnaSoundPath(self.tid, ttype))
    ttype = string.singleNumConverZeroNum(ttype)
    local trigger = string.format(format_str, self.tid, ttype)
    self.mAnimator:Play(trigger)
end

function playDefaultAni(self)
    self:playAni(dna.DnaHeroEggDataConfigVo.frameAniType.smile)
end

function onDnaBubbleFiniishWaitHandler(self)
    if not self.isInit then
        return
    end
    self:playDefaultAni()
end

return _M
