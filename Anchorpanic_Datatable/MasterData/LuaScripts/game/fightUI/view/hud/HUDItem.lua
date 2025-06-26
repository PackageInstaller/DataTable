
module("fightUI.HUDItem", Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
	self.m_rTrans = self.m_go:GetComponent(ty.RectTransform)

end

function onRecover(self)
	self.m_rTrans = nil

	GameDispatcher:removeEventListener(EventName.FIGHT_CAMERA_MOVE, self.onFightCamreaMove,self)
	
	if self.mFrameSn then
		LoopManager:removeFrameByIndex(self.mFrameSn)
		self.mFrameSn = nil
	end
    super.onRecover(self)
end

function setParent(self, parent, pos, offset)
	self.m_rTrans:SetParent(parent, false)

	self.mPos = pos
	self.mParent = parent
	self.mOffset = offset

	self:onUpdatePos()

	GameDispatcher:addEventListener(EventName.FIGHT_CAMERA_MOVE, self.onFightCamreaMove,self)
end

function onFightCamreaMove(self)
	if not self.mFrameSn then
		self.mFrameSn =  LoopManager:addFrame(1, 0, self, self.onUpdatePos)
	end
	self:onUpdatePos()
end

function onUpdatePos(self)
	gs.CameraMgr:World2UI(self.mPos,self.mParent,self.m_rTrans)
	if self.mOffset~=nil then
		local lp = self.m_rTrans.localPosition
		lp.y=lp.y+self.mOffset
		self.m_rTrans.localPosition = lp
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
