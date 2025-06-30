--[[   
     战斗波次提示
]]
module('fightUI.FightWaveView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
	self.m_waveTxt = self:getChildGO('WaveBigTxt'):GetComponent(ty.Text)
	self.m_timeoutSn = 0
end

function onRecover(self)
	RateLooper:clearTimeout(self.m_timeoutSn)
	self.m_timeoutSn = 0
	super.onRecover(self, onRecover)
end

function startWave( self )
	RateLooper:clearTimeout(self.m_timeoutSn)
	self.m_waveTxt.text = "波次 "..fight.FightManager:getWaveCnt()
	self:setActive(true)
	local function _timeoutCall()
		self.m_timeoutSn = 0
		self:setActive(false)
	end
	self.m_timeoutSn = RateLooper:setTimeout(1.5,self,_timeoutCall)
end


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
