--[[
-----------------------------------------------------
@filename       : LuaTabView
@Description    : GMLUA
@date           : 2022-2-22
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('gm.LuaTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('gm/LuaTab.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mInput = self:getChildGO("InputField"):GetComponent(ty.InputField)
    self.mBtnRun = self:getChildGO('RunButton')
    self.mBtnDel = self:getChildGO('DelButton')
    self.mBtnHideFps = self:getChildGO('HideFpsButton')
    self.mBtnShowFps = self:getChildGO('ShowFpsButton')
    self.mBtnRelogin = self:getChildGO('mBtnRelogin')
    self.mBtnSkipGuide = self:getChildGO('mBtnSkipGuide')
    self.mBtnDevictInfo = self:getChildGO('mBtnDevictInfo')
    self.mBtnIssueShow = self:getChildGO('mBtnIssueShow')
    self.mBtnTestHar = self:getChildGO('mBtnTestHar')

    self.mBtnCreateABLoadHistory = self:getChildGO('mBtnCreateABLoadHistory')
    self.mBtnGetABLoadHistory = self:getChildGO('mBtnGetABLoadHistory')
end

-- 初始化数据
function initData(self)
    self.mInput = nil
    self.mBtnRun = nil
    self.mBtnDel = nil
    self.mLuaFenv = setmetatable({}, { __index = _G })
end

function active(self)
    super.active(self)
    self:addOnClick(self.mBtnRun, self.__onRunLuaHandler)
    self:addOnClick(self.mBtnDel, self.__onRunDelHandler)
    self:addOnClick(self.mBtnHideFps, self.__onHideFpsHandler)
    self:addOnClick(self.mBtnShowFps, self.__onShowFpsHandler)
    self:addOnClick(self.mBtnRelogin, self.__onReloginHandler)
    self:addOnClick(self.mBtnSkipGuide, self.__onSkipGuideHandler)
    self:addOnClick(self.mBtnDevictInfo, self.__onClickDeviceInfoHandler)
    self:addOnClick(self.mBtnIssueShow, self.__onClickIssueShowHandler)

    self:addOnClick(self.mBtnCreateABLoadHistory, self.__onClickCreateABLoadHistoryHandler)
    self:addOnClick(self.mBtnGetABLoadHistory, self.__onClickGetABLoadHistoryHandler)
    self:addOnClick(self.mBtnTestHar, self.__onClickTestHarHandler)
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnRun)
    self:removeOnClick(self.mBtnDel)

    self:removeOnClick(self.mBtnHideFps)
    self:removeOnClick(self.mBtnShowFps)
    self:removeOnClick(self.mBtnRelogin)
    self:removeOnClick(self.mBtnSkipGuide)
    self:removeOnClick(self.mBtnDevictInfo)
    self:removeOnClick(self.mBtnIssueShow)
end

-- 执行Lua命令
function __onRunLuaHandler(self)
    local content = self.mInput.text
    if (content ~= "") then
        return self:eval(content, self.mLuaFenv)
    end
end

-- 删除代码
function __onRunDelHandler(self)
    self.mInput.text = ""
end

-- 隐藏FPS
function __onHideFpsHandler(self)
    debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, false)
end

-- 打开FPS
function __onShowFpsHandler(self)
    debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, true)
end

-- 返回登录界面
function __onReloginHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME,
        { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
end

function __onClickDeviceInfoHandler(self)
    local deviceName, cpuName, gpuName = sdk.SdkManager:getDeviceData()
    print("设备型号", deviceName)
    print("GPU名称", gpuName)
    print("CPU名称", cpuName)

    local isHarmonyOs, harmonyOsVersion = sdk.SdkManager:getHarmonyOsData()
    print("是否鸿蒙系统", isHarmonyOs)
    if (isHarmonyOs) then
        print("鸿蒙系统版本号", harmonyOsVersion)
    end

    print("是否模拟器系统", sdk.SdkManager:getIsSimulator())
    print("系统总内存", string.format("%.1fGB", gs.SdkManager:GetMemorySize("SystemTotalMemory") / 1024))
    print("系统剩余有效内存", string.format("%.1fGB", gs.SdkManager:GetMemorySize("SystemAvaliMemory") / 1024))
    print("分配给游戏的最大内存", string.format("%.1fGB", gs.SdkManager:GetMemorySize("GameMaxMemory") / 1024))
    print("游戏当前已使用的内存", string.format("%.1fGB", gs.SdkManager:GetMemorySize("GameUsedMemory") / 1024))
    print("显存", string.format("%.1fGB", CS.UnityEngine.SystemInfo.graphicsMemorySize / 1024))
end

function __onClickIssueShowHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_ISSUE_SHOW_PANEL, {})
    gm.GmManager:dispatchEvent(gm.GmManager.EVENT_VISIBLE_CHANGE, false)
    debugFrames.FPS:dispatchEvent(debugFrames.FPS.EVENT_VISIBLE_CHANGE, false)
end

function __onClickCreateABLoadHistoryHandler(self)
    if (gs.Directory.Exists(gs.PathUtil.GetPersistentAssetsWPath("ABLoadHistory"))) then
        gs.Directory.Delete(gs.PathUtil.GetPersistentAssetsWPath("ABLoadHistory"), true)
    end
    gs.Message.Show("创建ab加载历史文件成功，请重启")
    gs.Directory.CreateDirectory(gs.PathUtil.GetPersistentAssetsWPath("ABLoadHistory"))
end

function __onClickGetABLoadHistoryHandler(self)
    if (gs.File.Exists(gs.PathUtil.GetPersistentAssetsWPath("ABLoadHistory/ABLoadHistory.txt"))) then
        gs.SdkManager:Copy(gs.PathUtil.GetPersistentAssetsWPath("ABLoadHistory/ABLoadHistory.txt"))
        gs.Message.Show("复制ab加载历史文件成功")
        gs.SdkManager:CloseApplication()
    else
        gs.Message.Show("复制ab加载历史文件失败")
    end
end

function __onClickTestHarHandler(self)
    gs.Message.Show("操作成功，关闭界面重新进入")
    gm.GmManager.isTestHar = true
end

-- 跳过新手
function __onSkipGuideHandler(self)
    -- local value = StorageUtil:getString0('login_guide')
    -- StorageUtil:saveString0('login_guide', (value == "0" and 1 or 0))
    dup.DupClimbTowerManager.isGmOpen = true
    gs.Message.Show("无视开放日期设置成功~")
end

-- content：执行内容
-- customFenv：自定义环境
function eval(self, content, customFenv)
    if (type(content) == "string") then
        local strArr = string.split(content, "\n")
        content = ""
        for i = 1, #strArr do
            if (not self:isStrEmpty(strArr[i])) then
                if (content == "") then
                    content = strArr[i]
                else
                    content = content .. "," .. strArr[i]
                end
            end
        end

        local eval, err = loadstring("return " .. content)
        if not eval then
            eval, err = loadstring(content)
        end

        if eval then
            if customFenv then
                setfenv(eval, customFenv)
            end
            return eval()
        else
            print("加载代码时出错：" .. err)
        end
    end
end

function isStrEmpty(self, content)
    local isEmpty = true
    local tempStr = ""
    for i = 1, string.len(content) do
        tempStr = string.sub(content, i, i)
        if (tempStr ~= " ") then
            isEmpty = false
            break
        end
    end
    return isEmpty
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
