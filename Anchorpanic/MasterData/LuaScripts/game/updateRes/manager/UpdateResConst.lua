updateRes.ShowAlert = function(tipType, title, content, yesStr, yesFun, noStr, noFun)
	local data = {}
	data.tipType = tipType
	data.title = title
	data.content = content
	data.yesStr = yesStr
	data.yesFun = yesFun
	data.noStr = noStr
	data.noFun = noFun
	updateRes.UpdateResManager:dispatchEvent(updateRes.UpdateResManager.OPEN_ALERT_VIEW, data)
end

updateRes.TipType = {
    Normal = 1,
    Net = 2,
}

updateRes.ErrorCode = {
    -- 资源文件配置大小获取失败
    ServerVersionFileSizeError = "0",
    -- 下载服务器版本文件出错
    ServerVersionFileError = "1",
    -- 下载服务器版本文件完成，但文件不存在
    ServerVersionFileMiss = "2",
    -- 下载服务器版本文件完成，但解析出服务器版本号异常
    ServerVersionContentError = "3",
    -- 版本号校验异常
    VersionCompareError = "4",
    -- 下载资源文件列表出错
    ServerFileListError = "5",
    -- 下载资源文件列表完成，但文件不存在
    ServerFileListMiss = "6",
    -- 下载资源出错
    ServerResError = "7",

    -- Zip的初始化出错
    ZipInitError = "99",
    -- Zip的FileList.b下载出错
    ZipConfigDownLoadError = "100",
    -- Zip下载出错
    ZipDownLoadError = "101",
}

updateRes.initLayer = function()
    if(not updateRes.UICache)then
        updateRes.uiCache = CS.UnityEngine.GameObject.Find("[POOL_CACHE]").transform:Find("[UI_CACHE]").transform
        local rootTrans2 = CS.UnityEngine.GameObject.Find("[UI_ROOT]").transform
        updateRes.loading = rootTrans2:Find("LOADING")
        updateRes.alert = rootTrans2:Find("ALERT")
        updateRes.pop = rootTrans2:Find("POP")
    end
end
 
--[[ 替换语言包自动生成，请勿修改！
]]
