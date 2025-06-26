module("subPack.SubDownLoadItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTextTip = self:getChildGO("mTextTip"):GetComponent(ty.Text)
    self.mBtnStart = self:getChildGO("mBtnStart")
    self.mBtnCancel = self:getChildGO("mBtnCancel")

    self.mRectImgBar = self:getChildGO("mImgBar"):GetComponent(ty.RectTransform)
    gs.TransQuick:SizeDelta01(self.mRectImgBar, 0)
    self.mImgBarMaxWidth = 740

    self.mCacheDownLoadedKbSize = 0
end

function setData(self, param)
    super.setData(self, param)

    self:removeAllUIEvent()
    self:addUIEvent(self.mBtnStart, self.onClickStartHandler)
    self:addUIEvent(self.mBtnCancel, self.onClickCancelHandler)

    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_PROGRESS, self.onSubDownLoadProgressUpdateHandler, self)
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_MOVE, self.onSubDownLoadMoveUpdateHandler, self)
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, self.onSubDownLoadSuccessUpdateHandler, self)
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, self.onSubDownLoadFailUpdateHandler, self)

	local moduleType = self.data.module_type
    local textContent = self.data.tag_content
    local moduleTypeList = {moduleType}
    if (download.ResDownLoadManager:isModuleAssetsNeedUpdate(moduleTypeList)) then
        local downloadedKbSize, downloadMaxKbSize, downloadedCount, downloadMaxCount, movedCount, moveTotalCount = download.ResDownLoadManager:getDownLoadTaskData(moduleTypeList)
        if(downloadedKbSize <= 0)then
            local size = download.ResDownLoadManager:getModuleAssetsSize(moduleTypeList)
            local formatSize, unit = download.GetFormatSize(size)
            self.mTextTip.text = textContent .. " " .. tostring(formatSize) .. unit .. ""
            
            self.mBtnStart:SetActive(true)
            self.mBtnCancel:SetActive(false)
            self:setBtnLabel(self.mBtnStart, 0, "开始下载")
            gs.TransQuick:SizeDelta01(self.mRectImgBar, 0)

        elseif(downloadedKbSize < downloadMaxKbSize)then
            self.mCacheDownLoadedKbSize = downloadedKbSize
            local downloadedFormatSize, downloadedUnit = download.GetFormatSize(downloadedKbSize)
            local maxFormatSize, maxUnit = download.GetFormatSize(downloadMaxKbSize)
            
            self.mTextTip.text = textContent .. " " .. HtmlUtil:color(tostring(downloadedFormatSize) .. downloadedUnit, "FF9500FF") .. "/" .. tostring(maxFormatSize) .. maxUnit .. " (" .. string.format("%.2f", downloadedKbSize / downloadMaxKbSize * 100) .. "%)" -- .. "，" .. downloadedCount .. "个/" .. downloadMaxCount .. "个)"
            gs.TransQuick:SizeDelta01(self.mRectImgBar, self.mImgBarMaxWidth * downloadedKbSize / downloadMaxKbSize)

            if (not download.ResDownLoadManager:isModuleAssetsDownloading(moduleTypeList)) then
                self.mBtnStart:SetActive(true)
                self.mBtnCancel:SetActive(false)
                self:setBtnLabel(self.mBtnStart, 0, "继续下载")
            else
                self.mBtnStart:SetActive(false)
                self.mBtnCancel:SetActive(true)
                self:setBtnLabel(self.mBtnCancel, 0, "暂停下载")
            end
            
        elseif(downloadedKbSize >= downloadMaxKbSize)then
            gs.TransQuick:SizeDelta01(self.mRectImgBar, self.mImgBarMaxWidth)
            if(movedCount < moveTotalCount)then
                self.mTextTip.text = textContent .. " 请稍等，整理文件中：" .. movedCount .. "个/" .. moveTotalCount .. "个"
            else
                self.mTextTip.text = textContent .. " 下载资源成功"
            end
            self.mBtnStart:SetActive(false)
            self.mBtnCancel:SetActive(false)
        end
    else
        self.mTextTip.text = textContent .. " 下载资源成功"
        gs.TransQuick:SizeDelta01(self.mRectImgBar, self.mImgBarMaxWidth)
        self.mBtnStart:SetActive(false)
        self.mBtnCancel:SetActive(false)
    end
end

-- 静默下载进度更新
function onSubDownLoadProgressUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeList do
        local moduleType = taskData.moduleTypeList[i]
        if(moduleType == self.data.module_type)then
            local textContent = self.data.tag_content
            local downloadedFormatSize, downloadedUnit = download.GetFormatSize(taskData.downloadedKbSize)
            local maxFormatSize, maxUnit = download.GetFormatSize(taskData.downloadMaxKbSize)
            if(taskData.downloadedKbSize > self.mCacheDownLoadedKbSize)then
                self.mCacheDownLoadedKbSize = taskData.downloadedKbSize
                self.mTextTip.text = textContent .. " " .. HtmlUtil:color(tostring(downloadedFormatSize) .. downloadedUnit, "FF9500FF") .. "/" .. tostring(maxFormatSize) .. maxUnit .. " (" .. string.format("%.2f", taskData.downloadedKbSize / taskData.downloadMaxKbSize * 100) .. "%)" -- .. "，" .. taskData.downloadedCount .. "个/" .. taskData.downloadMaxCount .. "个)"
                gs.TransQuick:SizeDelta01(self.mRectImgBar, self.mImgBarMaxWidth * taskData.downloadedKbSize / taskData.downloadMaxKbSize)
            end
        end
    end
end

-- 静默下载整理更新
function onSubDownLoadMoveUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeList do
        local moduleType = taskData.moduleTypeList[i]
        if(moduleType == self.data.module_type)then
            local textContent = self.data.tag_content
            self.mTextTip.text = textContent .. " 请稍等，整理文件中：" .. taskData.movedCount .. "个/" .. taskData.moveTotalCount .. "个"

            self.mBtnStart:SetActive(false)
            self.mBtnCancel:SetActive(false)
        end
    end
end

-- 静默下载成功结果更新
function onSubDownLoadSuccessUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeSuccessList do
        local moduleType = taskData.moduleTypeSuccessList[i]
        if(moduleType == self.data.module_type)then
            local textContent = self.data.tag_content
            self.mTextTip.text = textContent .. " 下载资源成功"

            gs.TransQuick:SizeDelta01(self.mRectImgBar, self.mImgBarMaxWidth)
            self.mBtnStart:SetActive(false)
            self.mBtnCancel:SetActive(false)
            self.mCacheDownLoadedKbSize = 0
        end
    end
end

-- 静默下载失败结果更新
function onSubDownLoadFailUpdateHandler(self, args)
    local taskData = args
    for i = 1, #taskData.moduleTypeFailList do
        local moduleType = taskData.moduleTypeFailList[i]
        if(moduleType == self.data.module_type)then
            local textContent = self.data.tag_content
            self.mTextTip.text = textContent .. " 下载资源失败"

            self.mBtnStart:SetActive(true)
            self.mBtnCancel:SetActive(false)
            self:setBtnLabel(self.mBtnStart, 0, "重新下载")
            self.mCacheDownLoadedKbSize = 0
        end
    end
end

function onClickStartHandler(self)
	local moduleType = self.data.module_type
	local textContent = self.data.tag_content
	download.ResDownLoadManager:addDownLoadTask({moduleType})

    self.mBtnStart:SetActive(false)
    self.mBtnCancel:SetActive(true)
    self:setBtnLabel(self.mBtnCancel, 0, "暂停下载")
end

function onClickCancelHandler(self)
	local moduleType = self.data.module_type
	local result = download.ResDownLoadManager:cancelDownloadingModuleAssets(moduleType)
	if(result == true)then
		gs.Message.Show(self.data.tag_content .. "暂停下载成功")
	end

    self.mBtnStart:SetActive(true)
    self.mBtnCancel:SetActive(false)
    self:setBtnLabel(self.mBtnStart, 0, "继续下载")
end

function onClickDelHandler(self)
	local moduleType = self.data.module_type
	local result = download.ResDownLoadManager:delDownloadedModuleAssets(moduleType)
	if(result == true)then
		gs.Message.Show(self.data.tag_content .. "删除下载成功")
		local size = download.ResDownLoadManager:getModuleAssetsSize({moduleType})
		local formatSize, unit = download.GetFormatSize(size)
        self.mTextTip.text = self.data.tag_content .. " " .. tostring(formatSize) .. unit .. ""
	end
end

function deActive(self)
    super.deActive(self)
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_PROGRESS, self.onSubDownLoadProgressUpdateHandler, self)
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_MOVE, self.onSubDownLoadMoveUpdateHandler, self)
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, self.onSubDownLoadSuccessUpdateHandler, self)
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, self.onSubDownLoadFailUpdateHandler, self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
