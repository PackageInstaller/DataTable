--[[ 
-----------------------------------------------------
@filename       : DownLoadTabView
@Description    : 下载面板
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.DownLoadTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('gm/DownLoadTab.prefab')

--构造函数
function ctor(self)
	super.ctor(self)
end

function configUI(self)
	super.configUI(self)
end

-- 初始化数据
function initData(self)
	self.mTextTipKV = {}
	self.mCosxmlState = "Default"
end

--初始化UI
function configUI(self)
	self.mTextTip_1 = self:getChildGO("TextTip_1"):GetComponent(ty.Text)
	self.mBtnDownLoad_1 = self:getChildGO('DownLoadButton_1')
	self.mBtnCancel_1 = self:getChildGO('StopButton_1')
	self.mBtnDel_1 = self:getChildGO('DelButton_1')
	
	self.mTextTip_2 = self:getChildGO("TextTip_2"):GetComponent(ty.Text)
	self.mBtnDownLoad_2 = self:getChildGO('DownLoadButton_2')
	self.mBtnCancel_2 = self:getChildGO('StopButton_2')
	self.mBtnDel_2 = self:getChildGO('DelButton_2')

	self.mTextTipKV[download.ModuleType.BAG] = self.mTextTip_1
	self.mTextTipKV[download.ModuleType.TEST] = self.mTextTip_2
	
	-- 云桶模块
    self.mCosxmlServerFilePath = self:getChildGO("CosxmlServerFilePath"):GetComponent(ty.InputField)
    self.mCosxmlClientFilePath = self:getChildGO("CosxmlClientFilePath"):GetComponent(ty.InputField)
    self.mCosxmlSaveFilePath = self:getChildGO("CosxmlSaveFilePath"):GetComponent(ty.InputField)
	self.mBtnCosxmlUpLoad = self:getChildGO('UpLoadButton_cosxml')
	self.mBtnCosxmlDownLoad = self:getChildGO('DownLoadButton_cosxml')
end

-- UI事件管理
function addAllUIEvent(self)
	self:addUIEvent(self.mBtnDownLoad_1, self.__onDownLoadHandler, nil, download.ModuleType.BAG)
	self:addUIEvent(self.mBtnCancel_1, self.__onStopHandler, nil, download.ModuleType.BAG)
	self:addUIEvent(self.mBtnDel_1, self.__onDelHandler, nil, download.ModuleType.BAG)

	self:addUIEvent(self.mBtnDownLoad_2, self.__onDownLoadHandler, nil, download.ModuleType.TEST)
	self:addUIEvent(self.mBtnCancel_2, self.__onStopHandler, nil, download.ModuleType.TEST)
	self:addUIEvent(self.mBtnDel_2, self.__onDelHandler, nil, download.ModuleType.TEST)	

    self:addUIEvent(self.mBtnCosxmlUpLoad, self.onClickCosxmlUpLoadHandler)
    self:addUIEvent(self.mBtnCosxmlDownLoad, self.onClickCosxmlDownLoadHandler)
end

function active(self)
	super.active(self)
	
	local moduleType = download.ModuleType.BAG
	local size = download.ResDownLoadManager:getModuleAssetsSize({moduleType})
	local formatSize, unit = download.GetFormatSize(size)
	self.mTextTip_1.text = download.GetModuleName(moduleType) .. "需要下载：" .. tostring(formatSize) .. unit
	
	moduleType = download.ModuleType.TEST
	local size = download.ResDownLoadManager:getModuleAssetsSize({moduleType})
	local formatSize, unit = download.GetFormatSize(size)
	self.mTextTip_2.text = download.GetModuleName(moduleType) .. "需要下载：" .. tostring(formatSize) .. unit
end

function deActive(self)
	self:__onStopHandler(download.ModuleType.BAG)
	self:__onStopHandler(download.ModuleType.TEST)
	super.deActive(self)
	self.mCosxmlState = "Default"
end

--触发下载资源
function __onDownLoadHandler(self, moduleType)
	local type = moduleType
	local textTip = download.GetModuleName(type)
	local progerssFun = function(downloadedCount, maxCount, downloadedSizes, maxSizes)
		local str = math.floor(downloadedSizes / maxSizes * 100) .. "%(" .. downloadedCount .. "个/" .. maxCount .. "个)"
		self.mTextTipKV[type].text = textTip .. "：" .. str
	end
	local moveFun = function(movedCount, moveTotalCount)
		self.mTextTipKV[type].text = textTip .. "：正在整理下载资源：" .. movedCount .. "个/" .. moveTotalCount .. "个"
	end
	local successFun = function()
		self.mTextTipKV[type].text = textTip .. "：整理下载资源成功"
	end
	download.ResDownLoadManager:addDownLoadTask({type}, progerssFun, moveFun, successFun)
end

--暂停下载资源
function __onStopHandler(self, moduleType)
	local type = moduleType
	local result = download.ResDownLoadManager:cancelDownloadingModuleAssets(type)
	if(result == true)then
		gs.Message.Show(download.GetModuleName(type) .. "暂停成功")
	end
end

--删除下载的资源
function __onDelHandler(self, moduleType)
	local type = moduleType
	local result = download.ResDownLoadManager:delDownloadedModuleAssets(type)
	if(result == true)then
		gs.Message.Show(download.GetModuleName(type) .. "删除成功")
		local size = download.ResDownLoadManager:getModuleAssetsSize({type})
		local formatSize, unit = download.GetFormatSize(size)
		self.mTextTip_1.text = download.GetModuleName(type) .. "需要下载：".. tostring(formatSize) .. unit
	end
end

--云桶上传资源
function onClickCosxmlUpLoadHandler(self)
	if(self.mCosxmlState == "Default")then
		self.mCosxmlState = "UpLoad"
		local serverFilePath = self.mCosxmlServerFilePath.text
		local clientFilePath = self.mCosxmlClientFilePath.text
		local saveFilePath = self.mCosxmlSaveFilePath.text
		if(serverFilePath ~= "" and clientFilePath ~= "" and saveFilePath ~= "")then
			local function upLoadResultCall(result)
				if(result)then
					gs.Message.Show("云桶：上传成功")
				else
					gs.Message.Show("云桶：上传失败")
				end
				self.mCosxmlState = "Default"
			end
			sdk.SdkManager:cosxmlPutObject(serverFilePath, clientFilePath, nil, upLoadResultCall)
		end
	elseif(self.mCosxmlState == "UpLoad")then
		gs.Message.Show("云桶：正在上传中")
	elseif(self.mCosxmlState == "DownLoad")then
		gs.Message.Show("云桶：正在下载中")
	end
end

--云桶下载资源
function onClickCosxmlDownLoadHandler(self)
	if(self.mCosxmlState == "Default")then
		self.mCosxmlState = "DownLoad"
		local serverFilePath = self.mCosxmlServerFilePath.text
		local clientFilePath = self.mCosxmlClientFilePath.text
		local saveFilePath = self.mCosxmlSaveFilePath.text
		if(serverFilePath ~= "" and clientFilePath ~= "" and saveFilePath ~= "")then
			local function downLoadResultCall(result)
				if(result)then
					gs.Message.Show("云桶：下载成功")
				else
					gs.Message.Show("云桶：下载失败")
				end
				self.mCosxmlState = "Default"
			end
			local fileName = gs.Path.GetFileName(saveFilePath)
			local fileDir = string.split(saveFilePath, fileName)[1]
			sdk.SdkManager:cosxmlGetObject(serverFilePath, fileDir, fileName, nil, downLoadResultCall)
		end
	elseif(self.mCosxmlState == "UpLoad")then
		gs.Message.Show("云桶：正在上传中")
	elseif(self.mCosxmlState == "DownLoad")then
		gs.Message.Show("云桶：正在下载中")
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
