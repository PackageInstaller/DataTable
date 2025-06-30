--[[ 
-----------------------------------------------------
@filename       : VideoAdaptUtil
@Description    : 视频的视频方案
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module('VideoAdaptUtil', Class.impl())

function ctor(self)
	self:initData()
end

function initData(self)
end

-- 视频的标准原始大小
function getStandardSize(self)
	return 1920, 1080
end

-- 视频的安全区域大小
function getSafeSize(self)
	return 1440, 860
end

-- 临界比例
function getCriticalRatio(self)
	return 16 / 9
end

-- 获取视频的最后正确大小
function calculateVideoFormatSize(self)
	local videoSafeW, videoSafeH = self:getSafeSize()
	local videoStandardW, videoStandardH = self:getStandardSize()
	local criticalRatio = self:getCriticalRatio()
	local screenW, screenH = ScreenUtil:getScreenSize(nil)
	local ratio = screenW / screenH

	local scaleRatio = nil
	local scaleVideoW = nil
	local scaleVideoH = nil

	if(ratio > criticalRatio)then										-- 左右自适应，上下动态拉伸
		if(videoStandardW > screenW)then								-- 视频宽度大于屏幕宽度，缩小处理
			scaleRatio = videoStandardW / screenW
			scaleVideoW = screenW
			scaleVideoH = videoStandardH / scaleRatio
		else															-- 视频宽度小于屏幕宽度，放大处理
			scaleRatio = screenW / videoStandardW
			scaleVideoW = screenW
			scaleVideoH = videoStandardH * scaleRatio
		end
		if(scaleVideoH > screenH)then									-- 缩放后视频高度大于屏幕高度，需要裁剪
			if(screenH / scaleVideoH < videoSafeH / videoStandardH)then	-- 判断是否裁剪到安全区域
				scaleRatio = videoSafeH / screenH 						-- 裁剪到了安全区域，需要用视频的安全区域高度去自适应
				scaleVideoW = videoStandardW / scaleRatio
				scaleVideoH = videoStandardH / scaleRatio
			end
		end
	elseif(ratio <= criticalRatio)then									-- 上下自适应，左右动态拉伸
		if(videoStandardH > screenH)then								-- 视频高度大于屏幕高度，缩小处理
			scaleRatio = videoStandardH / screenH
			scaleVideoH = screenH
			scaleVideoW = videoStandardW / scaleRatio
		else															-- 视频高度小于屏幕高度，放大处理
			scaleRatio = screenH / videoStandardH
			scaleVideoH = screenH
			scaleVideoW = videoStandardW * scaleRatio
		end
		if(scaleVideoW > screenW)then									-- 缩放后视频宽度大于屏幕宽度，需要裁剪
			if(screenW / scaleVideoW < videoSafeW / videoStandardW)then	-- 判断是否裁剪到安全区域
				scaleRatio = videoSafeW / screenW 						-- 裁剪到了安全区域，需要用视频的安全区域宽度去自适应
				scaleVideoH = videoStandardH / scaleRatio
				scaleVideoW = videoStandardW / scaleRatio
			end
		end
	end
	return scaleVideoW or videoStandardW, scaleVideoH or videoStandardH
end

-- adaptType：适配类型（1：固定大小1920x1080；2：上下或左右自动适配；3：安全区域自动适配）
function updateSize(self, rect, adaptType)
	if rect and not gs.GoUtil.IsTransNull(rect) then
		if(adaptType == 1)then
			local screenW, screenH = ScreenUtil:getScreenSize(nil)
			rect.anchorMin = gs.Vector2(0.5, 0.5)
			rect.anchorMax = gs.Vector2(0.5, 0.5)
			rect.anchoredPosition = gs.Vector2(0, 0)
			gs.TransQuick:SizeDelta(rect, screenW, screenH)
		elseif(adaptType == 2)then
			local criticalRatio = self:getCriticalRatio()
			local screenW, screenH = ScreenUtil:getScreenSize(nil)
			local ratio = screenW / screenH
			if(ratio > criticalRatio)then
				local aspect = gs.GoUtil.AddComponent(rect.gameObject, ty.AspectRatioFitter)
				aspect.aspectRatio = self:getCriticalRatio()
				aspect.aspectMode = gs.AspectRatioFitter.AspectMode.HeightControlsWidth
				rect.anchorMin = gs.Vector2(0.5, 0)
				rect.anchorMax = gs.Vector2(0.5, 1)
				rect.anchoredPosition = gs.Vector2(0, 0)
				gs.TransQuick:SizeDelta02(rect, 0)
			elseif(ratio < criticalRatio)then
				local aspect = gs.GoUtil.AddComponent(rect.gameObject, ty.AspectRatioFitter)
				aspect.aspectRatio = self:getCriticalRatio()
				aspect.aspectMode = gs.AspectRatioFitter.AspectMode.WidthControlsHeight
				rect.anchorMin = gs.Vector2(0, 0.5)
				rect.anchorMax = gs.Vector2(1, 0.5)
				rect.anchoredPosition = gs.Vector2(0, 0)
				gs.TransQuick:SizeDelta01(rect, 0)
			else
				rect.anchorMin = gs.Vector2(0.5, 0.5)
				rect.anchorMax = gs.Vector2(0.5, 0.5)
				rect.anchoredPosition = gs.Vector2(0, 0)
				gs.TransQuick:SizeDelta(rect, screenW, screenH)
			end
		elseif(adaptType == 3)then
			gs.GoUtil.RemoveComponent(rect.gameObject, ty.AspectRatioFitter)
			rect.anchorMin = gs.Vector2(0.5, 0.5)
			rect.anchorMax = gs.Vector2(0.5, 0.5)
			rect.anchoredPosition = gs.Vector2(0, 0)
			local formatSizeW, formatSizeH = self:calculateVideoFormatSize()
			gs.TransQuick:SizeDelta(rect, formatSizeW, formatSizeH)
		end
	end
end

return _M
