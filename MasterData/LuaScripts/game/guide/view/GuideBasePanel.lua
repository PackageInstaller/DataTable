
-- module('guide.GuideBasePanel', Class.impl('lib.component.BaseContainer'))
module('guide.GuideBasePanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("guide/GuideUI.prefab")
panelType = 4
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0
isAdapta = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
 
function initData(self)
	self.m_curRectTran = nil
	
	self.m_curPos = nil
	self.m_nextPos = nil

	self.m_canvasOrder = 30

	self.m_clickTargetCall = nil
	self.m_clickBGCall= nil
	self.m_canClick = true
end

function setMask(self)
end
function __playOpenAction(self)
end

-- -- 打开窗口
-- function open(self)
-- 	if self.isPop == 1 then
--         return
--     end
--     self.isPop = 1
--     if self.UIObject then
--         self:addOnParent()
--     end
--     GameDispatcher:dispatchEvent(EventName.EVENT_UI_OPEN, self)
-- end

-- -- 关闭窗口
-- function close(self)
--     if self.isPop == 0 then
--         return
--     end
-- 	LoopManager:clearTimeout(self.m_delaySn)
-- 	self.m_delaySn = nil
--     self.isPop = 0
--     self.isCloseing = false

--     if self.UITrans then
--         self.UITrans:SetParent(GameView.UICache, false)
--     end
--     if self.UIBaseTrans then
--         self.UIBaseTrans:SetParent(GameView.UICache, false)
--     end
--     if self.UIRootNode then
--         self.UIRootNode:SetParent(GameView.UICache, false)
--     end
--     ----------------该顺序不可变------------------
--     -- 关闭UI的deactive先调用，再恢复其他UI（active）
--     self:__deActive()
--     ----------------该顺序不可变------------------
--     -- UI被完全关闭
--     self:dispatchEvent(EVENT_CLOSE)
-- 	GameDispatcher:dispatchEvent(EventName.EVENT_UI_CLOSE, self)
-- 	self:destroyPanel()
-- end

-- 关闭窗口
function close(self)
	super.close(self)
	self:destroyCanvas()
end


--初始化UI
function configUI(self)
	-- super.configUI(self)
	self.m_rootEventClick = self.UIObject:GetComponent(ty.EventClick)
	if not self.m_rootEventClick then
		self.m_rootEventClick = self.UIObject:AddComponent(ty.EventClick)
	end
	self.m_rootEventClick:AddClick(function ()
		if not self.m_canClick then return end

		if self.m_clickBGCall then
			self.m_clickBGCall()
		end
	end)
	self.m_rootEventClick:SetPierce(false)
	self.m_guideBGTrans = self:getChildTrans('GuideBG')

	self.m_guideBtn = self:getChildGO('GuideBtn')
	
	-- eventClick = self.m_guideBtn:GetComponent(ty.EventClick)
	-- if not eventClick then
	-- 	eventClick = self.m_guideBtn:AddComponent(ty.EventClick)
	-- end
	-- eventClick:AddClick(_bgClickCall)

	-- self.m_guideGo = self:getChildGO('GuideBG')
	self.m_maskTrans = self:getChildTrans('GuideMask')
	self.m_maskEfxTrans = self:getChildTrans('GuideEfx_root')
	self.m_maskEfxRectTrans = self:getChildGO("GuideEfx_root"):GetComponent(ty.RectTransform)

	self.m_contentRtrans = self:getChildTrans('ContentGroup'):GetComponent(ty.RectTransform)
end

-- 取父容器
function getParentTrans(self)
    return GameView.guide
end

function setClickCall(self, targetCall, bgCall)
	self.m_clickTargetCall = targetCall
	self.m_clickBGCall = bgCall
end

--设置遮罩初始位置形状
function setStartMask(self, rectTransform, displayTargetTrans, isClickItem,guideData)
	local function _delayCall()
		self.m_delaySn = nil
		if self:_setObjMask(rectTransform, displayTargetTrans, isClickItem,guideData) then
			if guideData.box_type[1] == 4 then 
				self:setMask4(rectTransform.gameObject)
			end

			local retPos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetUICamera(), gs.CameraMgr:GetUICamera(), self.m_nextPos, self.m_maskTrans.parent)

			local needPos= gs.VEC2_ZERO
			local pos_x = guideData.box_type[4] or 0
			local pos_y = guideData.box_type[5] or 0
			needPos.x  = retPos.x + pos_x
			needPos.y  = retPos.y + pos_y
			self.m_maskTrans.anchoredPosition = needPos
			self.m_maskEfxRectTrans.anchoredPosition = needPos


			needPos= gs.VEC2_ZERO
			needPos.x  = retPos.x + guideData.posx
			needPos.y  = retPos.y + guideData.posy
			self.m_contentRtrans.anchoredPosition = needPos


			self.m_maskTrans.gameObject:SetActive(true)
			self.m_maskEfxTrans.gameObject:SetActive(true)
		end
		self.m_canClick = true
	end
	self.m_canClick = false
	LoopManager:clearTimeout(self.m_delaySn)
	self.m_delaySn = LoopManager:setTimeout(0.05, self, _delayCall)
end

--根据传入的物体设置遮罩
-- nextRectTran：下一个引导的位置
function setObjMask(self, nextRectTran, displayTargetTrans, isClickItem,guideData,callback)
	local function _delayCall()
		self.m_delaySn = nil
		if self:_setObjMask(nextRectTran, displayTargetTrans, isClickItem,guideData) then
			self.m_maskEventClick:SetOnlyPenetrateEvent(true)
			self.m_maskTrans.gameObject:SetActive(true)
			self.m_maskEfxTrans.gameObject:SetActive(true)

			local retPos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetUICamera(), gs.CameraMgr:GetUICamera(), self.m_nextPos, self.m_maskTrans.parent)

			local needPos= gs.VEC2_ZERO
			local pos_x = guideData.box_type[4] or 0
			local pos_y = guideData.box_type[5] or 0
			needPos.x  = retPos.x + pos_x
			needPos.y  = retPos.y + pos_y
			self.m_maskTrans.anchoredPosition = needPos
			self.m_maskEfxRectTrans.anchoredPosition = needPos


			needPos= gs.VEC2_ZERO
			needPos.x  = retPos.x + guideData.posx
			needPos.y  = retPos.y + guideData.posy
			self.m_contentRtrans.anchoredPosition = needPos


			if callback then 
				callback()
			end
		end
		self.m_canClick = true
	end
	self.m_canClick = false
	LoopManager:clearTimeout(self.m_delaySn)
	self.m_delaySn = LoopManager:setTimeout(0.01, self, _delayCall)
end

function hideMask(self)
	self.m_maskTrans.gameObject:SetActive(false)
	self.m_maskEfxTrans.gameObject:SetActive(false)
end

-- nextRectTran：下一个引导的位置
function _setObjMask(self, nextRectTrans, displayTargetTrans, isClickItem,guideData)
	if nextRectTrans and guideData then
		local tmpTrans = nextRectTrans
		if displayTargetTrans then
			tmpTrans = displayTargetTrans
		end
		self.m_nextPos = gs.TransQuick:RTransCenterV3(tmpTrans)

		self:setCanvasLayer(nextRectTrans, isClickItem)

		if not string.NullOrEmpty(self.m_CurEfxName) then 
			self:removeEffect(self.m_CurEfxName)
			self.m_CurEfxName = nil
		end

		if not string.NullOrEmpty(guideData.click_efx_name) then 
			self:addEffect(guideData.click_efx_name,self.m_maskEfxTrans)
			self.m_CurEfxName = guideData.click_efx_name
		end

		local mask_type = guideData.box_type[1]
		if mask_type == 1 or mask_type == 2 or mask_type == 5 then
			local width = guideData.box_type[2] or 0
			local height = guideData.box_type[3] or 0

			if width == 0 and width == 0 then
				width = tmpTrans.rect.width+10
				height = tmpTrans.rect.height+10
				gs.TransQuick:SizeDelta(self.m_childTrans["GuideMask_" .. mask_type], width, height)
				if  mask_type == 5 then
					width = tmpTrans.rect.width+46
					height = tmpTrans.rect.height+36
				elseif  mask_type == 1 then
					width = tmpTrans.rect.width+44
					height = tmpTrans.rect.height+36
				end

				gs.TransQuick:SizeDelta(self.m_childTrans["GuideEfx_" .. mask_type], width, height)
			else
				if  mask_type == 5 then
					gs.TransQuick:SizeDelta(self.m_childTrans["GuideMask_" .. mask_type], width - 36, height - 26)
				elseif  mask_type == 1 then
					gs.TransQuick:SizeDelta(self.m_childTrans["GuideMask_" .. mask_type], width - 34 , height - 26)

				end
				local maskTrans = self.m_childTrans["GuideEfx_" .. mask_type]
				gs.TransQuick:SizeDelta(maskTrans, width, height)


			end
		end
		self:setMaskType(guideData)
		return true
	end
	Debug:log_error("GuidePanel", "不存在目标Transform ")
	return false
end

--设置mask类型
function setMaskType(self,guideData)
	local maskType = guideData.box_type[1]
	for i=1,5 do
		self.m_childGos["GuideMask_" .. i]:SetActive(maskType == i)
		self.m_childGos["GuideEfx_" .. i]:SetActive(maskType == i)
	end
	local mask_Go = self.m_childGos["GuideMask_" .. maskType]
	self.m_maskEventClick = mask_Go:GetComponent(ty.EventClick)
	if not self.m_maskEventClick then
		self.m_maskEventClick = mask_Go.gameObject:AddComponent(ty.EventClick)
	end

	self.m_maskEventClick:RemoveClick()
	self.m_maskEventClick:AddClick(function ()
		if not self.m_canClick then return end

		if self.m_clickBGCall then
			self.m_clickBGCall()
		end
	end)
	self.m_maskEventClick:SetOnlyPenetrateEvent(true)
end

function setMask4(self,clickObj)
	if  (clickObj == nil or gs.GoUtil.IsGoNull(clickObj)) then 
		return 
	end
	local oldParent = clickObj.transform.parent
	clickObj.transform:SetParent(self.m_maskEfxTrans,false)

	local clickCall = function ()
		if clickObj and not gs.GoUtil.IsGoNull(clickObj) then
			clickObj.transform:SetParent(oldParent,false)
		end

		self:destroyCanvas()
		if self.m_clickTargetCall then
			self.m_clickTargetCall()
		end
	end
	self:addClickCall(clickObj,clickCall)
end

function setFullMask(self)
	self.m_maskEventClick:SetOnlyPenetrateEvent(false)
	self.m_maskTrans.gameObject:SetActive(true)
	self.m_maskEfxTrans.gameObject:SetActive(true)
	local w, h = ScreenUtil:getScreenSize()
	gs.TransQuick:SizeDelta(self.m_maskTrans, w*2, h*2)
	gs.TransQuick:UIPos(self.m_maskTrans, 0, 0)

	s.TransQuick:SizeDelta(self.m_maskEfxTrans, w*2, h*2)
	gs.TransQuick:UIPos(self.m_maskEfxTrans, 0, 0)
end

local OUTLINE_V2 = gs.Vector2(4,-4)
local OUTLINE_COLOR = gs.ColorUtil.GetColor("FFF34280")

--设置目标物体的渲层级
function setCanvasLayer(self, nextRectTran, isClickItem)
	self:destroyCanvas()
	if nextRectTran then
		self.m_curRectTran = nextRectTran
		-- -- self.m_curRectParent = self.m_curRectTran.parent
		-- -- self.m_curRectTran:SetParent(self.m_guideBGTrans, true)
		-- local nexCanvas = self.m_curRectTran:GetComponent(ty.Canvas)

		-- -- self.m_curTransImg = self.m_curRectTran:GetComponent(ty.Image)
		-- -- if not self.m_curTransImg then
		-- -- 	self.m_curTransImg = self.m_curRectTran:GetComponent(ty.AutoRefImage)
		-- -- end
		-- -- if self.m_curTransImg then
		-- -- 	self.m_maskImg.sprite = self.m_curTransImg.sprite
		-- -- 	self.m_curImgMat = self.m_curTransImg.material
		-- -- 	guide.GuideManager:setupMaskTargetMat(self.m_curTransImg)
		-- -- 	-- self.m_curOutline = self.m_curRectTran:GetComponent(ty.Outline)
		-- -- 	-- if not self.m_curOutline then
		-- -- 	-- 	self.m_curOutline = self.m_curRectTran.gameObject:AddComponent(ty.Outline)
		-- -- 	-- end
		-- -- 	-- self.m_curOutline.effectColor = OUTLINE_COLOR
		-- -- 	-- self.m_curOutline.effectDistance = V2
			
		-- -- 	self.m_guideBtn:SetActive(false)
		-- -- 	-- self.m_maskImg:SetNativeSize()
		-- -- else
		-- -- 	self.m_maskImg.sprite = nil
		-- -- 	self.m_guideBtn:SetActive(true)
		-- -- end
		
		-- if nexCanvas==nil or gs.GoUtil.IsCompNull(nexCanvas) then
		-- 	nexCanvas = self.m_curRectTran.gameObject:AddComponent(ty.Canvas)
		-- 	-- self.m_curRectTran.gameObject:AddComponent(ty.GraphicRaycaster)
		-- end

		-- local function _delayCall()
		-- 	self.m_canvasSn = nil
		-- 	if gs.GoUtil.IsCompNull(nexCanvas) then return end
		-- 	nexCanvas.overrideSorting = true
		-- 	nexCanvas.sortingOrder = self.m_canvasOrder+1	--设置渲染层级
		-- 	if gs.GoUtil.IsCompNull(self.m_curRectTran.gameObject:GetComponent(ty.GraphicRaycaster)) then
		-- 		self.m_curRectTran.gameObject:AddComponent(ty.GraphicRaycaster)
		-- 	end
		-- end
		-- LoopManager:clearTimeout(self.m_canvasSn)
		-- self.m_canvasSn = LoopManager:setTimeout(0.1, self, _delayCall)

		if isClickItem then
			local function _clickCall()
				self:destroyCanvas()
				if self.m_clickTargetCall then
					self.m_clickTargetCall()
				end

				self.m_contentRtrans.anchoredPosition = gs.Vector2(10000,10000)
			end
			self:addClickCall(nextRectTran.gameObject,_clickCall)
		end
	end
end

function addClickCall(self,gameObject,m_clickTargetCall)
	local eventClick = gameObject:GetComponent(ty.EventClick)
	if not eventClick then
		eventClick = gameObject:AddComponent(ty.EventClick)
	end
	eventClick:AddClick(m_clickTargetCall)
end

--销毁canvas组件
function destroyCanvas(self)
	if self.m_curRectTran then
		-- -- if self.m_curTransImg then
		-- -- 	if self.m_curImgMat then
		-- -- 		self.m_curTransImg.material = self.m_curImgMat
		-- -- 		self.m_curImgMat = nil
		-- -- 	else
		-- -- 		guide.GuideManager:reductionMaskTarget(self.m_curTransImg)
		-- -- 	end
		-- -- 	self.m_curTransImg = nil
		-- -- end
		
		-- self.m_curRectTran:SetParent(self.m_curRectParent, true)
		-- self.m_curRectParent = nil
		-- local canvas = self.m_curRectTran.gameObject:GetComponent(ty.Canvas)
		-- if canvas then
		-- 	local graphicRay = self.m_curRectTran:GetComponent(ty.GraphicRaycaster)
		-- 	if graphicRay then
		-- 		gs.GameObject.Destroy(graphicRay)
		-- 	end
		-- 	gs.GameObject.Destroy(canvas)
		-- end
		if not gs.GoUtil.IsTransNull(self.m_curRectTran) then
			local eventClick = self.m_curRectTran:GetComponent(ty.EventClick)
			if eventClick then
				gs.GameObject.Destroy(eventClick)
			end
		end
		-- self.m_maskImg.sprite = nil
	end
	self.m_curRectTran = nil
end


return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
