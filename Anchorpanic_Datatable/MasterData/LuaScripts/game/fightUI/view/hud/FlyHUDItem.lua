module("fightUI.FlyHUDItem", Class.impl(fightUI.HUDItem))

function ctor(self)
	super.ctor(self)
	self.m_prefabName = UrlManager:getUIPrefabPath("fight/FlyHudText.prefab")
	-- self.m_prefabName = "FlyHudText.prefab"
end

-- 初始化数据
function initData(self, rootGo)
	super.initData(self, rootGo)
	-- self.mTxtFlyNum = self.m_go:GetComponent(ty.Text)
	-- self.m_ani = self.m_go:GetComponent(ty.Animation)
	self.mTxtFlyNumGo = self:getChildGO("mTxtFlyNum")
	self.mTxtFlyNumTrans = self.mTxtFlyNumGo.transform
	self.mTxtFlyNum = self.mTxtFlyNumGo:GetComponent(ty.Text)
	self.m_ani = self.mTxtFlyNumGo:GetComponent(ty.Animation)

	self.mTxtCritGo = self:getChildGO("mTxtCrit")
	self.mTxtCrit = self.mTxtCritGo:GetComponent(ty.Text)
end

function setFont(self, font)
	self.mTxtFlyNum.font = font
	self.mTxtCrit.font = font
end


function setColor(self, color)
	-- self.mTxtFlyNum.color = color
end

function setVal(self, val)
	self.mTxtFlyNum.text = val
end

-- 设置暴击
function setCrit(self, val)
	self.mTxtCrit.text = val
end

function preloadAnim(self, aniPath)
	if self.m_ani then
		gs.DynamicAnimation:PreloadAnimation(self.m_ani, aniPath)
	end
end

function playAnim(self, aniPath, finishCall)
	if self.m_ani then
		local function _finishCall()
			gs.ColorUtil.SetColorA(self.mTxtFlyNum, 1)
			self.mTxtFlyNum:GetComponent(ty.CanvasGroup).alpha = 1

			if finishCall then finishCall() end
		end
		local length = gs.DynamicAnimation:PlayAnimation04(self.m_ani, aniPath)
		if length>0 then
			self.m_timeoutIndex = LoopManager:setTimeout(length, self, _finishCall)
		else
			self.m_timeoutIndex = LoopManager:setTimeout(1, self, _finishCall)
		end
	end
end

function getTextCurrPosY(self)
	local y1 = self.mTxtFlyNumTrans.localPosition.y
	local y2 = self.m_rTrans.localPosition.y
	return y1 + y2
end

function addPosY(self,offset)
	gs.TransQuick:LPosOffsetY(self.m_rTrans, offset)
end

function onRecover(self)
	super.onRecover(self)
	gs.TransQuick:LPosZero(self.mTxtFlyNumTrans)
	if self.m_timeoutIndex ~= nil then
		LoopManager:clearTimeout(self.m_timeoutIndex)
		self.m_timeoutIndex = nil
	end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
