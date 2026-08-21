-- @FileName:   BigHostelManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.bigHostel.manager.BigHostelManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    --max_dormitory_data

    self.m_mainUIShowModelId = nil
    self.m_mainModelTempData = nil

    self.StartGame = false

    self.m_uiComponentShowState = {}
    self.m_sceneProps = {}
    self.m_dualViewEnabled = false
end

function parseModelCvConfigData(self)
    self.m_ModelCvDic = {}

    local baseData = RefMgr:getData("hero_action_cv_data")
    for key, data in pairs(baseData) do
        local baseVo = bigHostel.BigHostelModelConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_ModelCvDic[key] = baseVo
    end
end

function getModelCv(self, model_id)
    if not self.m_ModelCvDic then
        self:parseModelCvConfigData()
    end

    return self.m_ModelCvDic[model_id]
end

-------------------------------------------------------------------临时数据
function disableFreeCameraReset(self, val, callEvent)
    self.m_disableFreeCameraReset = val
    if callEvent ~= false then
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_DISABLEFREECAMERARESET, self.m_disableFreeCameraReset)
    end
end

function getDisableFreeCameraReset(self)
    return self.m_disableFreeCameraReset or false
end

--当前入场的动画
function setMainShowModelId(self, val)
    self.m_mainUIShowModelId = val
end

function getMainShowModelId(self)
    return self.m_mainUIShowModelId
end

--主界面是否显示大宿舍
function setMainUIShow(self, value)
    StorageUtil:saveTable1(gstor.BGHOSTEL_MAINSCENESTATE, value)
end

function getMainUIShow(self)
    local hostel_data = StorageUtil:getTable1(gstor.BGHOSTEL_MAINSCENESTATE)
    if table.empty(hostel_data) then
        return false
    end

    return true, hostel_data
end

function setMainModelTempData(self, data)
    if not self.StartGame then
        return
    end

    self.m_mainModelTempData = data

    StorageUtil:saveTable1(gstor.BGHOSTEL_MAINSCENEINFO, data)
end

function getMainModelTempData(self)
    if not self.m_mainModelTempData then
        self.m_mainModelTempData = StorageUtil:getTable1(gstor.BGHOSTEL_MAINSCENEINFO)
    end

    return self.m_mainModelTempData
end

function setIsCanInteract(self, val)
    self.m_canInteract = val
end

function getIsCanInteract(self)
    return self.m_canInteract == nil and true or self.m_canInteract
end

--{heroConfigVo,model_id,main_type}
function setHostelData(self, heroData)
    self.m_heroData = heroData
end

function getHostelHero(self)
    return self.m_heroData
end

function setSceneModel(self, model)
    self.m_model = model
end

function getSceneModel(self)
    return self.m_model
end

--设置大宿舍双视图开关
function setDualViewEnabled(self, value)
    self.m_dualViewEnabled = value == true
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_DUALVIEW_ENABLE_CHANGE, self.m_dualViewEnabled)
end

function getDualViewEnabled(self)
    return self.m_dualViewEnabled == true
end

--通知共享SceneUI在运行时目标回收前解除双视图绑定
function releaseDualViewTarget(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_DUALVIEW_TARGET_RELEASE)
end

function setUIComponentShowState(self, args)
    self.m_uiComponentShowState[args.key] = args
end

function getUIComponentShowState(self)
    return self.m_uiComponentShowState
end

function clearUIComponentShowState(self )
    self.m_uiComponentShowState = {}
end

function setSceneProps(self, args)
    self.m_sceneProps = args
end

function getSceneProps(self)
    return self.m_sceneProps
end

return _M
