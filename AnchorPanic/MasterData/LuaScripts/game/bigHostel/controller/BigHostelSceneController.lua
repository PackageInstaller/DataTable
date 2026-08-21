-- @FileName:   BigHostelSceneController.lua
-- @Description:   大宿舍
-- @Author: ZDH
-- @Date:   2025-04-21 16:13:35
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.controller.BigHostelSceneController', Class.impl(map.MapBaseController))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:clearScene()
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onShowMainUIHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 开始加载前
function beforeLoad(self)
    -- 关闭登录的初始加载界面
    if (loginLoad.LoginLoadController:isLoginLoading()) then
        loginLoad.LoginLoadController:destroyLoading()
    end

    local model_data = bigHostel.BigHostelManager:getHostelHero()
    if model_data then
        local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(model_data.heroTid, model_data.model_id)
        if sceneData then
            UIFactory:startForcibly(sceneData:getRandomLoad())
            return
        end
    end

    UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    -- logAll(gs.Time.time, "场景加载完成-------")

    if not self.roomScene then
        self.roomScene = bigHostel.BigHostelScene.new()
    end
    self.roomScene:setup(function ()
        local model_data = bigHostel.BigHostelManager:getHostelHero()
        if model_data.main_type == BigHostelConst.SceneUI_Type.MIANUI then
            mainCity.MainCityManager.isLoadCompleted = true
            Perset3dHandler:toNormalShowData()

            LoopManager:addFrame(1, 1, self, function()
                local isGuide = guide.GuideManager:checkResetGuide()
                if isGuide then
                    -- 检查下新手引导
                    if battleMap.MainMapManager.isDataInit then
                        guide.GuideManager:startTodoEvent()
                    end
                else

                    local waitOpenUIcode = mainui.MainUIManager:getWaitOpenUIcode()
                    if waitOpenUIcode > 0 then
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = waitOpenUIcode})
                        mainui.MainUIManager:setWaitOpenUIcode(0)
                    end

                    GameDispatcher:dispatchEvent(EventName.START_CHECK_TRIGGER_DOWNLOADSTART_CHECK_TRIGGER_DOWNLOAD)
                    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_SHOW_BEFORE_UI)-- 通知打开战斗前的功能UI
                end
            end)
        else
            super.playSceneMusic(self)
        end
        -- logAll(gs.Time.time, "模型加载完成-------")

        UIFactory:closeForcibly()
    end)
end

-- 播放场景音乐
function playSceneMusic(self)

end

-- 关闭当前地图
function clearMap(self)
    super.clearMap(self)

    local model_data = bigHostel.BigHostelManager:getHostelHero()
    if model_data.main_type ~= BigHostelConst.SceneUI_Type.MIANUI or bigHostel.BigHostelManager:getMainUIShow() ~= true then
        UIFactory:startForcibly()
    end

    self:clearScene()
end

function clearScene(self)
    if self.roomScene then
        self.roomScene:reset()
    end
    self.roomScene = nil
end

-- 判断大宿舍是否激活状态
function checkSceneActive(self)
    if self.roomScene then
        return true
    end
    return false
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.BIG_HOSTEL
end

-- 地图资源名
function getMapID(self)
    local model_data = bigHostel.BigHostelManager:getHostelHero()
    if model_data then
        local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(model_data.heroTid, model_data.model_id)
        if sceneData then
            return sceneData.sceneId
        end
    end
end

-- 回到主界面，重新激活bgm
function onShowMainUIHandler(self)
    if self:checkSceneActive() then
        super.playSceneMusic(self)
    else
        mainCity.MainCityController:playMainCityMusic()
    end
end

return _M
