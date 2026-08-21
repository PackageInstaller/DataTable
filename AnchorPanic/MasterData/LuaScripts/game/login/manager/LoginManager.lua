module('login.LoginManager', Class.impl(Manager))

EVENT_LOGIN = 'EVENT_LOGIN'

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
    -- 游戏服账号登录是否成功，用于判断断线时是进行重连还是进行服务器列表检测登录(重登不处理该数据)
    self.isAccHadLoginSuc = false
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 首次创角时间
    self.createRoleTime = 0
    -- 是否首次创角
    self.isFirstCreateRole = false
    -- socket登录时session（用于断线重连）
    self.gameLoginSession = ''
    -- 登录返回角色id
    self.gameLoginPlayerId = ''

    -- 单公告接口数据
    self.mLoginBulletinData = nil
    -- 资源预加载字典
    self.mPreloadLoadConfigDic = nil


    self.clientAuthLv = 0
    self.clientAuthId = StorageUtil:getString0('login_client_auth_id')
    self.clientAuthPwd = StorageUtil:getString0('login_client_auth_pwd')
end

-- 初始化预加载配置表
function parsePreloadConfigData(self)
    if (not login.PreloadRo) then
        login.PreloadRo = require('rodata/PrerloadResDataRo')
    end
    self.mPreloadLoadConfigDic = {}
    local baseData = RefMgr:getData("prerload_res_data")
    for preloadType, data in pairs(baseData) do
        local vo = login.PreloadRo.new()
        vo:parseData(preloadType, data)
        self.mPreloadLoadConfigDic[preloadType] = vo
    end
end

-- 获取预加载配置
function getPreloadConfigVo(self, preloadType)
    if (not self.mPreloadLoadConfigDic) then
        self:parsePreloadConfigData()
    end
    return self.mPreloadLoadConfigDic[preloadType]
end

-- 单公告接口：设置公告数据
function setLoginBulletinData(self, bulletinDataList)
    if (bulletinDataList and bulletinDataList[1]) then
        self.mLoginBulletinData = { title = bulletinDataList[1].title, content = CS.Lylibs.UTF8StringUtil.GetString(bulletinDataList[1].content[1]) }
    else
        self.mLoginBulletinData = nil
    end
end

-- 单公告接口：获取公告数据
function getLoginBulletinData(self)
    local isEditor = CS.Lylibs.ApplicationUtil.IsEditorRun
    if (isEditor and not self.mLoginBulletinData) then
        self.mLoginBulletinData = { title = "测试标题", content = "测试内容" }
    end
    return self.mLoginBulletinData
end

function setLoginViewVisible(self, visible)
    self.mLoginViewVisible = visible
end
function getLoginViewVisible(self)
    return self.mLoginViewVisible
end

function setIsLoginPreLoaded(self, isLoaded)
    self.mIsLoginPreLoaded = isLoaded
end
function getIsLoginPreLoaded(self)
    return self.mIsLoginPreLoaded
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]