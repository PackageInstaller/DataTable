
module("fashion.FashionPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("fashion/FashionPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(62502))
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
    -- self.camera = Perset3dHandler:getSceneShowData(MainCityConst.ROLE_MODE_OVERVIEW).cameraNodeTrans
    -- self.originPos = self.camera.localPosition
    -- self.targetPos = gs.Vector3(0.2, self.originPos.y, self.originPos.z)
end

function configUI(self)
    super.configUI(self)
    -- self.mClickerArea = self:getChildGO("mClickerArea")
    -- self.mModelPlayer = ModelScenePlayer.new()
end

function active(self, args)
    super.active(self, args)
    self:recoverMoneyBar()
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FASHION_PANEL, self.__onUpdatePanelHandler, self)

    if (args.type) then
        self:setType(args.type, { fashionId = args.fashionId })
    end
    self.base_childGos["mGroupCusTab"]:SetActive(false)

    -- local function toTargetPos(self)
    --     local nowPos = self.camera.localPosition
    --     self.camera.localPosition = gs.Vector3.Lerp(nowPos, self.targetPos, 0.2)
    --     if(gs.Vector3.Distance(self.camera.localPosition, self.targetPos) < 0.01) then 
    --         LoopManager:removeFrameByIndex(self.mUpdateFrame)
    --         self.mUpdateFrame = nil
    --     end
    -- end
    -- self.mUpdateFrame = LoopManager:addFrame(1, 0, self, toTargetPos)
end



function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FASHION_PANEL, self.__onUpdatePanelHandler, self)
    self:__recoverModel(true)

    -- local function toOriginPos(self)
    --     local nowPos = self.camera.localPosition
    --     self.camera.localPosition = gs.Vector3.Lerp(nowPos, self.originPos, 0.2)
    --     if(gs.Vector3.Distance(self.camera.localPosition, self.originPos) < 0.01) then 
    --         LoopManager:removeFrameByIndex(self.mUpdateFrame)
    --         self.mUpdateFrame = nil
    --     end
    -- end
    -- self.mUpdateFrame = LoopManager:addFrame(1, 0, self, toOriginPos)
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList = {}
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FASHION_CLOTHES, false) then
        self.tabDataList[1] = TabData:poolGet():setData(178, 70, { fashion.getTabName(fashion.Type.CLOTHES), "Clothes" }, "common_2201.png", "common_3219.png", 20, nil, fashion.Type.CLOTHES, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40 }, { 25, 0, 0, 15, 25, 0, 0, 40 })
    end
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FASHION_WEAPON, false) then
    --     self.tabDataList[2] = TabData:poolGet():setData(178, 70, { fashion.getTabName(fashion.Type.WEAPON), "Weapon" }, "common_2201.png", "common_3219.png", 20, nil, fashion.Type.WEAPON, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40 }, { 25, 0, 0, 15, 25, 0, 0, 40 })
    -- end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[fashion.Type.CLOTHES] = fashion.FashionClothesTabView
    -- self.tabClassDic[fashion.Type.WEAPON] = fashion.FashionWeaponTabView
    return self.tabClassDic
end

-- 点击菜单
function onClickMenuHandler(self, cusTabType)
    self:setType(cusTabType, { fashionId = nil })
end

function setType(self, cusTabType, cusArgs)
    self.args[cusTabType] = cusArgs
    super.setType(self, cusTabType, cusArgs, false)
    -- if (not self.mModelPlayer:getModelTrans()) then
    --     self:__updateModelView()
    --     self:setBg("", false)
    -- end
    self:__onUpdatePanelHandler()
end

function __updateModelView(self)
    -- local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    -- if (heroVo) then
    --     self.mModelPlayer:setData(heroVo.id, false, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, UrlManager:getBgPath("common/common_bg_005.jpg"), self.mClickerArea, true, nil)
    -- else
    --     self:__recoverModel(false)
    -- end
end

function __recoverModel(self, isResetMaincity)
    -- self.mModelPlayer:reset(isResetMaincity)
end

function __onUpdatePanelHandler(self, args)
    self:updateBubbleView()
end

function updateBubbleView(self)
    local function _updateBubble(_tabType, _isFlag)
        if (_isFlag) then
            self:addBubble(_tabType)
        else
            self:removeBubble(_tabType)
        end
    end
    _updateBubble(fashion.Type.CLOTHES, fashion.FashionManager:isHeroFashionListBubble(fashion.Type.CLOTHES, fashion.FashionManager:getHeroId()))
    -- _updateBubble(fashion.Type.WEAPON, fashion.FashionManager:isHeroFashionListBubble(fashion.Type.WEAPON, fashion.FashionManager:getHeroId()))
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]