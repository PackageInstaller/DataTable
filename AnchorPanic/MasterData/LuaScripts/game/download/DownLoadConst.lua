-- 资源更新状态（和C#类ResDownLoadHandler的UpdateState一致）
download.ResState = {
	Init = 0,						--正在为您初始化资源包
	ReadLocalVersion = 1,			--读取本地版本号
	ReadCdnVersion = 2,				--读取cdn版本号
	CompareVersion = 3,				--检测版本号
	CompareAssetVersion = 4, 		--比对所有版本文件
	DownloadFiles = 5,				--资源正在下载
	DownloadFilesMove = 6,         	--资源下载移动
	DownloadFilesSuc = 7,       	--资源下载成功
	DownloadFilesFail = 8,       	--资源下载失败
	SaveVersion = 9,				--保存版本
	Finished = 10,					--更新完毕,祝你游戏愉快
}

-- zip更新状态（和C#类ZipDownLoadManager的ZipDownloadState一致）
download.ZipState = {
	Uninitialized = 0,
	Initialized = 1,
	GetSubZipInfo = 2,
	Rsynced = 3,
	Restore = 4,
	Downloading = 5,
	Downloaded = 6
}

-- 资源更新类型（和C#类FileVersionVo的FileType一致）
download.FileType = {
    -- 配置
    Config = 0,
    -- Lua文件
    LuaFile = 1,
    -- AB包
    AB = 2,
    -- Lua代码Zip包
    LuaZip = 3,
    -- AB资源Zip包
    ABZip = 4,
	-- 额外不打包文件
	ExtraUpPack = 5,
}

-- 资源模块类型（和C#类AssetsUtils的ModuleType一致）
download.ModuleType = {
	-- Lua代码资源
	LUA = 100,
	-- 核心资源
	CORE = 200,
	-- 更新界面资源
	UPDATE_RES = 300,
	-- 公用资源
	COMMON = 400,

	-- 剩余兜底资源
	REMAIN = 10000,
}

download.GetModuleName = function(moduleType)
	local name = ""
	if(moduleType == download.ModuleType.CORE)then
		name = _TT(40)
	elseif(moduleType == download.ModuleType.COMMON)then
		name = _TT(41)
	elseif(moduleType == download.ModuleType.UPDATE_RES)then
		name = _TT(42)
	elseif(moduleType == download.ModuleType.LUA)then
		name = "代码资源"
	elseif(moduleType == download.ModuleType.REMAIN)then
		name = "剩余资源"
	else
		name = "资源"
	end
	return name
end

-- 根据大小(KB)获取带单位字符串
download.GetFormatSize = function(kbSize)
	if(kbSize < 999)then
		return tonumber(string.format("%.1f", kbSize)), "KB"
	else
		return tonumber(string.format("%.2f", kbSize / 1024)), "MB"
	end
end

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(45):	"竞技场资源"
	语言包: _TT(44):	"背包资源"
	语言包: _TT(43):	"基础资源"
	语言包: _TT(42):	"更新界面资源"
	语言包: _TT(41):	"公用资源"
	语言包: _TT(40):	"核心资源"
]]
