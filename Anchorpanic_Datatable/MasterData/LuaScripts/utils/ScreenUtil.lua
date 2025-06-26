module('ScreenUtil', Class.impl())

function ctor(self)
end

function getStandardSize(self)
	return 1624, 750
end

function getRealSize(self)
	return math.floor(gs.Screen.width), math.floor(gs.Screen.height)
end

function getScreenSize(self, ratio)
	ratio = ratio == nil and 1 or ratio
	-- if(not self.mScreenW and not self.mScreenH)then
		if not self.mCanvas then
			self.mCanvas = gs.GameObject.Find("[UI_ROOT]"):GetComponent(ty.Canvas)
		end
		if self.mCanvas then
			local rect = self.mCanvas.transform.rect
			self.mScreenW = math.floor(rect.width)
			self.mScreenH = math.floor(rect.height)
		else
			self.mScreenW = math.floor(gs.Screen.width)
			self.mScreenH = math.floor(gs.Screen.height)
		end
	-- end
	return self.mScreenW * ratio, self.mScreenH * ratio
end

function getMatchWidthOrHeight(self)
	local standardW, standardH = self:getScreenSize(nil)
	local standardRatio = standardW / standardH

	local screenW, screenH = self:getRealSize()
	local screenRatio = screenW / screenH

	if (screenRatio > standardRatio)then
		return 1
	else
		return 0
	end
end

function getOriginalScale(self)
	local originalScale = 1
	local standardW, standardH = self:getScreenSize(nil)
	local standardRatio = standardW / standardH
	local screenW, screenH = self:getRealSize()
	local screenRatio = screenW / screenH
	if(standardRatio ~= screenRatio)then				--原始大小是否被缩放过
		if(self:getMatchWidthOrHeight() <= 0.5)then			--原始宽度是否变化
			if(standardW < screenW)then
				-- 原始宽度被放大
				originalScale = screenW / standardW
			else
				-- 原始宽度被缩小
				originalScale = - standardW / screenW
			end
		elseif(self:getMatchWidthOrHeight() > 0.5)then		--原始高度是否变化
			if(standardH < screenH)then
				-- 原始高度被放大
				originalScale = screenH / standardH
			else
				-- 原始高度被缩小
				originalScale = - standardH / screenH
			end
		end
	end
	return originalScale
end

function getScale(self)
	local scale = 1

	local standardW, standardH = self:getScreenSize(nil)
	local standardRatio = standardW / standardH

	local screenW, screenH = self:getRealSize()
	local screenRatio = screenW / screenH

	if(screenRatio > standardRatio)then
		scale = screenW / standardW
	elseif(screenRatio < standardRatio)then
		scale = screenH / standardH
	end
	
	local originalScale = self:getOriginalScale()
	if(originalScale > 0)then
		-- 原始大小被放大，需缩小
		return scale / math.abs(originalScale)
	else
		-- 原始大小被缩小，需放大
		return scale * math.abs(originalScale)
	end
end

-- 是否是窄屏
function isSmallScreen(self)
	local standardW, standardH = self:getScreenSize(nil)
    if standardW <= 1400 then
        return true
    end
    return false
end

function getNotchHeight(self)
    if ScreenUtil:isSmallScreen() then
        return 0
    end
    -- 设备刘海高度（0没有）(28为美术效果预留，刘海屏按实际刘海减去预留就可以刘海贴边)
    local notchHeight = math.max(gs.DeviceInfoMgr.GetNotchHeigt() - 28, 0)
	return notchHeight
end

return _M
