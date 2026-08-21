-- @FileName:   BigHostelController.lua
-- @Description:   大宿舍
-- @Author: ZDH
-- @Date:   2025-04-21 16:11:07
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.controller.BigHostelController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
    self.mMgr.StartGame = true
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_BIGHOSTEL_SCENE, self.openHostelScene, self)
    GameDispatcher:addEventListener(EventName.OPEN_BIGHOSTEL_SCENEUI, self.onOpenBigHostelSceneUI, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BIGHOSTEL_SCENEUI, self.onCloseBigHostelSceneUI, self)

    GameDispatcher:addEventListener(EventName.OPEN_BIGHOSTEL_BLACKUI, self.onOpenBigHostelBlackView, self)
    GameDispatcher:addEventListener(EventName.CLOSE_BIGHOSTEL_BLACKUI, self.onCloseBigHostelBlackView, self)

    GameDispatcher:addEventListener(EventName.OPEN_BIGHOSTEL_POSEUI, self.onOpenBigHostelPoseUI, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end
---------------------------数据---------------------------------------

---------------------------界面---------------------------------------

function onOpenBigHostelSceneUI(self, args)
    if self.mBigHostelSceneUI == nil then
        self.mBigHostelSceneUI = UI.new(bigHostel.BigHostelSceneUI)
        self.mBigHostelSceneUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelSceneUI, self)
    end

    self.mBigHostelSceneUI:open(args)
end

function onCloseBigHostelSceneUI(self, args)
    if self.mBigHostelSceneUI ~= nil and self.mBigHostelSceneUI.isPop then
        self.mBigHostelSceneUI:close()
    end
end
-- ui销毁
function onDestroyBigHostelSceneUI(self)
    self.mBigHostelSceneUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelSceneUI, self)
    self.mBigHostelSceneUI = nil
end

function onOpenBigHostelPoseUI(self, args)
    if self.mBigHostelPoseUI == nil then
        self.mBigHostelPoseUI = UI.new(bigHostel.BigHostelPoseUI)
        self.mBigHostelPoseUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelPoseUI, self)
    end

    self.mBigHostelPoseUI:open(args)
end
-- ui销毁
function onDestroyBigHostelPoseUI(self)
    self.mBigHostelPoseUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelPoseUI, self)
    self.mBigHostelPoseUI = nil
end

function onOpenBigHostelBlackView(self, args)
    if self.mBigHostelBlackView == nil then
        self.mBigHostelBlackView = UI.new(bigHostel.BigHostelBlackView)
        self.mBigHostelBlackView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelBlackView, self)
    end

    self.mBigHostelBlackView:open(args)
end

function onCloseBigHostelBlackView(self, args)
    if self.mBigHostelBlackView ~= nil and self.mBigHostelBlackView.isPop then
        self.mBigHostelBlackView:close()
    end
end

-- ui销毁
function onDestroyBigHostelBlackView(self)
    self.mBigHostelBlackView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBigHostelBlackView, self)
    self.mBigHostelBlackView = nil
end

---进入宿舍场景
function openHostelScene(self, args)
    local sceneData = purchase.FashionShopManager:getFashionSceneDataByModelId(args.heroTid, args.model_id)
    if sceneData then
        args.main_type = args.main_type or BigHostelConst.SceneUI_Type.INTERACTIVE

        if args.main_type == BigHostelConst.SceneUI_Type.TRIAL or hero.HeroManager:getHeroSceneUnlock(args.heroTid, sceneData.id) then
            local model_data = bigHostel.BigHostelManager:getHostelHero()
            if model_data == nil or args.heroTid ~= model_data.heroTid or args.model_id ~= model_data.model_id or args.main_type ~= model_data.main_type or bigHostel.BigHostelSceneController:checkSceneActive() == false then
                bigHostel.BigHostelManager:setHostelData(args)
                map.MapLoader:setIsForceLoad(true)
                GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BIG_HOSTEL)
            end

            if args.main_type == BigHostelConst.SceneUI_Type.MIANUI then
                bigHostel.BigHostelManager:setMainUIShow({model_id = args.model_id, heroTid = args.heroTid})
            end
        else
            UIFactory:alertMessge(_TT(84519), true, function()
                GameDispatcher:dispatchEvent(EventName.OPEN_SHOPPING_PANEL, {type = ShopMainTabType.Recharge, subType = purchase.TabType.SKIN_SHOP, openFashionType = fashionShop.ShopType.SCENE})
            end, _TT(1), nil, true, nil, _TT(2))
        end
    end
end

return _M
