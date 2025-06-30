
module('guide.GuidePanelTools', Class.impl(guide.GuideBasePanel))

--初始化UI
function configUI(self)
	super.configUI(self)
		
	self.m_contentGo = self:getChildGO('ContentGroup')
	local img = self.m_contentGo:AddComponent(ty.Image)
	local c = img.color
	c.a = 0
	img.color = c
	local dragUI = self.m_contentGo:AddComponent(ty.DragUI)
	local function _contentMove()
		local aPos = self.m_contentRtrans.anchoredPosition
		self.m_xInput:SetInputTxt(aPos.x)
		self.m_yInput:SetInputTxt(aPos.y)
	end
	dragUI:SetLazyDragCall(_contentMove, 0.2)
	self.m_contentRtrans = self.m_contentGo:GetComponent(ty.RectTransform)
	self.m_contentBGRTrans = self:getChildGO('ContentBG'):GetComponent(ty.RectTransform)
	self.m_contentBGSize = self.m_contentBGRTrans.sizeDelta
	self.m_contentTxt = self:getChildGO('ContentTxt'):GetComponent(ty.Text)
	self.m_contentImg = self:getChildGO('IconImg'):GetComponent(ty.AutoRefImage)

	self.m_toolsGo = self:getChildGO('ToolsGroup')
	self.m_toolsGo:SetActive(true)
	self.m_toolsRTrans = self.m_toolsGo:GetComponent(ty.RectTransform)
	self.m_toolsBGSize = self.m_toolsRTrans.sizeDelta

	self.m_frameGroupGo = self:getChildGO('FrameGroup')
	self.m_guideMaskRTrans = self:getChildGO('GuideMask'):GetComponent(ty.RectTransform)
	local eventClick = self:getChildGO('GuideMask'):GetComponent(ty.EventClick)
	if eventClick then
		gs.GameObject.Destroy(eventClick)
	end
	self.m_guideMaskSize = self.m_guideMaskRTrans.sizeDelta
	self.m_guideMaskRTrans.gameObject:SetActive(false)
	dragUI = self:getChildGO('GuideMask'):AddComponent(ty.DragUI)
	local function _guideMaskMove()
		local aPos = self.m_guideMaskRTrans.anchoredPosition
		self.m_xxInput:SetInputTxt(aPos.x)
		self.m_yyInput:SetInputTxt(aPos.y)
	end
	dragUI:SetLazyDragCall(_guideMaskMove, 0.2)

	self.m_xInput = self:getChildGO("XTInput"):GetComponent(typeof(CS.STInput))
	self.m_yInput = self:getChildGO("YTInput"):GetComponent(typeof(CS.STInput))
	self.m_wInput = self:getChildGO("WTInput"):GetComponent(typeof(CS.STInput))

	self.m_xxInput = self:getChildGO("XXTInput"):GetComponent(typeof(CS.STInput))
	self.m_yyInput = self:getChildGO("YYTInput"):GetComponent(typeof(CS.STInput))
	self.m_wwInput = self:getChildGO("WWTInput"):GetComponent(typeof(CS.STInput))
	self.m_hhInput = self:getChildGO("HHTInput"):GetComponent(typeof(CS.STInput))

	local function _xywSetupCall()
		local x = self.m_xInput:GetInputFloatVal()
		local y = self.m_yInput:GetInputFloatVal()
		local w = self.m_wInput:GetInputFloatVal()
		-- if x>0 and y>0 then
		-- 	gs.TransQuick:UIPos(self.m_contentRtrans, x,y)
		-- else
		-- 	logError("xyError ,x:%.2f, y:%.2f", x, y)
		-- end
		gs.TransQuick:UIPos(self.m_contentRtrans, x,y)
		if w>0 then
			self.m_contentBGSize.x = w
			self.m_contentBGRTrans.sizeDelta = self.m_contentBGSize
		else
			logError("wError, w:%.2f", w)
		end
	end
	local function _xywSetupCall2()
		local x = self.m_xxInput:GetInputFloatVal()
		local y = self.m_yyInput:GetInputFloatVal()
		local w = self.m_wwInput:GetInputFloatVal()
		local h = self.m_hhInput:GetInputFloatVal()
		gs.TransQuick:UIPos(self.m_guideMaskRTrans, x,y)
		if w>0 and h>0 then
			self.m_guideMaskSize.x = w
			self.m_guideMaskSize.y = h
			self.m_guideMaskRTrans.sizeDelta = self.m_guideMaskSize
		else
			logError("wh2Error, ww:%.2f, hh:%.2f", w, h)
		end
	end
	self:addOnClick(self:getChildGO('ToolsGoBtn'), _xywSetupCall)
	self:addOnClick(self:getChildGO('ToolsGoBtn2'), _xywSetupCall2)
	local function _closeCall()
		GameDispatcher:dispatchEvent(EventName.CLOSE_GUIDE_TOOLS_PANEL)
	end
	self:addOnClick(self:getChildGO('ToolsCloseBtn'), _closeCall)
	
	local function _toggleCall(bVal)
		self.m_frameGroupGo:SetActive(bVal)
		self.m_guideMaskRTrans.gameObject:SetActive(bVal)
		if bVal then
			self.m_toolsBGSize.y = 115
		else
			self.m_toolsBGSize.y = 72
		end
		self.m_toolsRTrans.sizeDelta = self.m_toolsBGSize
    end
    self:getChildGO("FrameToggle"):GetComponent(ty.Toggle).onValueChanged:AddListener(_toggleCall)
end


return _M 


 
--[[ 替换语言包自动生成，请勿修改！
]]
