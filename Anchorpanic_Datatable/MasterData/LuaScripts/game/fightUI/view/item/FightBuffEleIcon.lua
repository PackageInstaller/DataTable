
module('fightUI.FightBuffEleIcon', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
		
	self.m_iconImg = self.m_go:GetComponent(ty.AutoRefImage)
end

function setElePrefab(self, path)
	if path then
		local uieffGo = gs.ResMgr:LoadGO(path)
		if uieffGo then
			gs.TransQuick:SetParentOrg(uieffGo.transform, self.m_trans)
		end
	end
end

function setIcon( self, imgKey )
	if imgKey then
		-- print("FightBuffIcon===", imgKey)
		self.m_iconImg:SetImg(imgKey, false)
	end
	if self.m_scaleTween then
		self.m_scaleTween:Kill()
	end
	local function _finishCall()
		self.m_scaleTween = nil	
	end
	self.m_scaleTween = TweenFactory:scaleTo01(self.m_trans, 0.55, 1, 0.7, nil, _finishCall)
end

function removeSelf(self)
	if self.m_scaleTween then
		self.m_scaleTween:Kill()
		self.m_scaleTween = nil	
	end
	super.removeSelf(self)
end


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
