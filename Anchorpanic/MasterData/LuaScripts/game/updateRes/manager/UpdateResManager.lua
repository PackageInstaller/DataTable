module("updateRes.UpdateResManager", Class.impl('lib.event.EventDispatcher'))

-- 显示加载界面
SHOW_LOADING_VIEW = 'SHOW_LOADING_VIEW'
-- 更新加载界面
UPDATE_LOADING = 'UPDATE_LOADING'
-- 关闭加载界面
CLOSE_LOADING_VIEW = 'CLOSE_LOADING_VIEW'

-- 打开Alert界面
OPEN_ALERT_VIEW = "OPEN_ALERT_VIEW"
-- 关闭Alert界面
CLOSE_ALERT_VIEW = "CLOSE_ALERT_VIEW"

--构造函数
function ctor(self)
	super.ctor(self)
end

--析构函数
function dtor(self)
end

-- 设置本次资源更新是否需要重启游戏
function setIsNeedRestart(self, isNeedRestart)
	self.m_isNeedRestart = isNeedRestart
end

-- 获取本次资源更新是否需要重启游戏
function getIsNeedRestart(self)
	return self.m_isNeedRestart
end

-- 地址末尾需带/
function getCdnUrl(self)
	local game_cdn = web.WebManager.game_cdn
	local assetServerList = web.WebManager.server_list
	if(assetServerList and #assetServerList > 0) then
		-- 随便取出一个serverVo的cdn
		local serverVo = assetServerList[1]
		if(serverVo.game_cdn ~= "") then
			game_cdn = serverVo.game_cdn
			print("取出web服务器列表里的cdn作为资源更新地址")
		end
	end
	local cdnUrl = game_cdn
	if(not string.ends(game_cdn, "/"))then
		cdnUrl = cdnUrl .. "/"
	end
	return cdnUrl
end

function getStateTip(self, state)
	local tip = ""
	if(state == nil) then
		state = download.ResDownLoadManager:getUpdateState()
	end
	if(state == download.ResState.Init) then
		tip = "准备检查更新中"
	elseif(state == download.ResState.ReadLocalVersion) then
		tip = "读取客户端版本中"
	elseif(state == download.ResState.ReadCdnVersion) then
		tip = "读取服务器版本中"
	elseif(state == download.ResState.CompareVersion) then
		tip = "版本号比对中"
	elseif(state == download.ResState.CompareAssetVersion) then
		tip = "差异资源比对中"
	elseif(state == download.ResState.DownloadFiles) then
		tip = "正在下载"
	elseif(state == download.ResState.DownloadFilesMove) then
		tip = "正在下载"
	elseif(state == download.ResState.DownloadFilesSuc) then
		tip = "正在下载"
	elseif(state == download.ResState.DownloadFilesFail) then
		tip = "网络异常"
	elseif(state == download.ResState.SaveVersion) then
		tip = "正在保存版本中"
	elseif(state == download.ResState.Finished) then
		tip = "更新完毕，正在检查环境中"
	end
	return tip
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
