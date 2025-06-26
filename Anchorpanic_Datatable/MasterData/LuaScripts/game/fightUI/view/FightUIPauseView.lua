--[[   
     战斗暂停界面
]]
module('fight.FightUIPauseView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('fight/FightUIPause.prefab')

destroyTime = 0 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
	super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle('')
end

function initData(self)
	
end

--初始化UI
function configUI(self)
	self.m_btnExit = self:getChildGO('mBtnExit')
	self:addOnClick(self.m_btnExit, self.onExitHandler)
	
	self.m_btnAgain = self:getChildGO('mBtnAgain')
	self:addOnClick(self.m_btnAgain, self.onAgainHandler)
	
	self.m_btnContinue = self:getChildGO('mBtnContinue')
	self:addOnClick(self.m_btnContinue, self.onContinueHandler)
end

function drawPanel(self)
end

-- 点击退出
function onExitHandler(self)
	self:close()
	GameDispatcher:dispatchEvent(EventName.FIGHT_REQ_END)
end

-- 点击再次挑战
function onAgainHandler(self)
	self:close()
	GameDispatcher:dispatchEvent(EventName.FIGHT_REQ_END)
	GameDispatcher:dispatchEvent(EventName.FIGHT_AGAIN)
end

-- 点击继续
function onContinueHandler(self)
	self:close()
end

--激活
function active(self)
	fight.FightManager:setIsPause(true)
	self:__updateView()
end

--非激活
function deActive(self)
	fight.FightManager:setIsPause(false)
end

function __updateView(self)
	local battleType = fight.FightManager:getBattleType()
	if(battleType == PreFightBattleType.ArenaChallenge)then
		self.m_btnExit:SetActive(false)
		self.m_btnAgain:SetActive(false)
	else
		self.m_btnExit:SetActive(true)
		self.m_btnAgain:SetActive(true)
	end
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
