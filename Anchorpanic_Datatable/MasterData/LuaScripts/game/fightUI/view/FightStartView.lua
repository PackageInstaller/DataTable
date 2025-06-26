module('fightUI.FightStartView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_itemInfos = {}
    self.m_tweens = {}
    --self.m_scrollTrans = self:getChildGO('ScrollTxt'):GetComponent(ty.RectTransform)

    --self.m_startTxt = self:getChildGO('StartTxt'):GetComponent(ty.Text)

    -- local rTrans = self:getChildGO('StartTxt'):GetComponent(ty.RectTransform)
    -- table.insert(self.m_itemInfos, {self.m_startTxt, rTrans, rTrans.anchoredPosition })
    -- for i=1,7 do
    -- 	local rTrans = self:getChildGO('Image'..i):GetComponent(ty.RectTransform)
    -- 	table.insert(self.m_itemInfos, {self:getChildGO('Image'..i):GetComponent(ty.Image), rTrans, rTrans.anchoredPosition})
    -- end
    -- self:hide()
end

-- function hide(self)
--     self:close()
--     for _, v in ipairs(self.m_itemInfos) do
--         gs.TransQuick:UIPos(v[2], math.random(-2000, 2000), math.random(-1000, 1000))
--     end
--     gs.TransQuick:UIPosX(self.m_scrollTrans, 1200)
-- end

function start(self, finishCall)
    -- self:hide()
    -- local lastTweener = nil
    -- for _,v in ipairs(self.m_itemInfos) do
    -- 	lastTweener = v[2]:DOMoveUI(v[3], 0.5, gs.DT.Ease.InOutBack)--InSine)
    -- 	table.insert(self.m_tweens, lastTweener)
    -- end
    -- if lastTweener then
    -- 	local function _finishCall()
    -- 		self.m_tweens = {}
    -- 		local scrollTween = self.m_scrollTrans:DOMoveUIX(-100, 1.5)
    -- 		local function _finishCall2()
    -- 			if finishCall then finishCall() end
    -- 		end
    -- 		scrollTween:OnComplete(_finishCall2)			
    -- 	end
    -- 	lastTweener:OnComplete(_finishCall)
    -- 	return
    -- end
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_start_mission.prefab"))

    self.mTimeoutSn = LoopManager:setTimeout(1, self, function()
        if finishCall then finishCall() end
    end)

    local sceneRo = fight.SceneManager:getSceneData(fight.SceneManager:getMapID())
    if sceneRo then
        local animaNames = sceneRo:getSceneAnimaNames()
        if animaNames and not table.empty(animaNames) then
            for _, name in ipairs(animaNames) do
                local go = gs.GameObject.Find(name)
                if go and go:GetComponent(ty.Animator) then
                    go:GetComponent(ty.Animator):SetTrigger("READY")
                end
            end
        end
    end
end

function close(self)
    -- if not table.empty(self.m_tweens) then
    -- 	for _,v in ipairs(self.m_tweens) do
    -- 		v:Kill()
    -- 	end
    -- 	self.m_tweens = {}
    -- end
end

function removeSelf(self)
    super.removeSelf(self)
    if self.mTimeoutSn then
        LoopManager:clearTimeout(self.mTimeoutSn)
        self.mTimeoutSn = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]