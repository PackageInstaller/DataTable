--[[   
     战斗内buff图标
]]
module('fightUI.FightBuffIcon', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
		
	self.mImgIcon = self:getChildGO('mImgIcon'):GetComponent(ty.AutoRefImage)
	self.mTxtLevel = self:getChildGO('mTxtLevel'):GetComponent(ty.Text)
	self.mTxtRound = self:getChildGO('mTxtRound'):GetComponent(ty.Text)
end

function setTxtData(self, round, level)
	if round>0 then
		self.mTxtRound.text = round
	else
		self.mTxtRound.text = ""
	end
	if level>0 then
		self.mTxtLevel.text = level
	else
		self.mTxtLevel.text = ""
	end	
end

function setIcon( self, imgKey )
	-- print("FightBuffIcon===", imgKey)
	self.mImgIcon:SetImg(imgKey, false)
end


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
