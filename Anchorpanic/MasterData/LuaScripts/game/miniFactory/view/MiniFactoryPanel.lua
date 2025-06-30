--[[ 
-----------------------------------------------------
@filename       : MiniFacPanel
@Description    : 迷你工厂面板
@date           : 2022-2-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFacPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("factory/MiniFactoryPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("", false)
    self:setTxtTitle(_TT(72108))
    self:setUICode(LinkCode.MiniFacory)
end

function initData(self)
    self.mOneDaySec = 3600 * 24   --一天多少秒
    self.mModelItemList = {}
    self.mAnimatorDic = {}
    --3D特效目录
    self.mEffectList = {}
    --3D特效目录
    self.mEffectDic = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")
    self.mBtnPackage = self:getChildGO("mBtnPackage")
    self.mEventTrigger = self:getChildGO("mTouchArea"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mBtnProduceList = self:getChildGO("mBtnProduceList")
    self.mTextProduceTip = self:getChildGO("mTextProduceTip"):GetComponent(ty.Text)
    self.mTextProduce = self:getChildGO("mTextProduce"):GetComponent(ty.Text)
    self.mTextListNum = self:getChildGO("mTextListNum"):GetComponent(ty.Text)


    self:setGuideTrans("funcTips_factory_1", self:getChildTrans("mFuncTips_factory_1"))
    self:setGuideTrans("funcTips_factory_2", self:getChildTrans("mFuncTips_factory_2"))
    self:setGuideTrans("funcTips_factory_3", self:getChildTrans("mFuncTips_factory_3"))
    --self:setGuideTrans("funcTips_factory_4", self:getChildTrans("mFuncTips_factory_4"))
    self:setGuideTrans("funcTips_factory_4", self:getChildTrans("mBtnProduceList"))
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.POWER_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MINIFAC_ANISTATE, self.updateFactoryState, self)
    self.sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
    self:updateView()
    self:updateEnterListView()
    local function _onPointerUpHandler()
        if self.sceneCamera then
            self:onUpdateRayDetection()
        end
    end
    self.mEventTrigger.onPointerUp:AddListener(_onPointerUpHandler)
    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_INFO)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    self.mEventTrigger.onPointerUp:RemoveAllListeners()
    GameDispatcher:removeEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MINIFAC_ANISTATE, self.updateFactoryState, self)
    self:recoverModelList()
    self:recoverAllGrid()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecAll, self.onClickRecHandler)
    self:addUIEvent(self.mBtnPackage, self.onOpenPackageHandler)
    self:addUIEvent(self.mBtnProduceList, self.onOpenProduceListHandler)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function initViewText(self)
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose(true)
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

--打开背包
function onOpenPackageHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BAG_PANEL, { tabType = bag.BagTabType.RAWMAT })
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.MiniFacory })
end

--打开生产列表
function onOpenProduceListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_PRODUCE_LIST_PANEL)
end
--打开产能兑换
function onClickOpenConvertHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_CAPACITY_VIEW)
end

--一键领取
function onClickRecHandler(self)
    if miniFac.MiniFactoryManager:getCompleteOrderCount() > 0 then
        if bag.BagManager:bagIsFull(nil, bag.BagType.Rawmat) == false then
            GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_ALLRECEIVE)
        else
            gs.Message.Show(_TT(325))
        end
    else
        if #miniFac.MiniFactoryManager:getProduceList() > 0 then
            gs.Message.Show(_TT(60514))
        else
            gs.Message.Show(_TT(60515))
        end
    end
end

function updateView(self)
    self:updateProduceBtnTxt()
    self:updateEnterListView()
end

--更新3D场景上的2D按钮挂载
function updateUI(self)
    for k, btnItem in pairs(self.mModelItemList) do
        local parent = gs.GameObject.Find("Environment/building/ui_miniwork_0" .. k .. "/Canvas/mPos" .. k).transform
        self.mModelItemList[k]:setParentTrans(parent)
    end
end

-- 7个模块入口界面
function updateEnterListView(self)
    self:recoverModelList()
    for _, configVo in pairs(miniFac.MiniFactoryManager:getFactoryDic()) do
        if configVo.showTipsName > 0 or funcopen.FuncOpenManager:isOpen(configVo.funcId, false) == true then
            local item = miniFac.MiniFactoryFormulaItem.new()
            item:setData(configVo)
            local btnTrans = self:getChildTrans("mPos" .. configVo.type .. "_ui")
            local btnfather = self:getChildTrans("mFactoryTrans_" .. configVo.type)
            local btn = btnTrans.gameObject:GetComponent(ty.Button)
            if guide.GuideManager:getCurHasGuide() == true then
                self:setGuideTrans("guide_MiniFactory_" .. configVo.type, btnTrans)
                self:addUIEvent(btnTrans.gameObject, function()
                    item:onClickHandler()
                end)
            end
            local aniNode = gs.GameObject.Find("Environment/building/modelui_miniwork_0" .. configVo.type):GetComponent(ty.Animator)
            item:setParentTrans(btnfather)
            self.mAnimatorDic[configVo.type] = aniNode
            table.insert(self.mModelItemList, item)
        else
            self:getChildGO("mPos" .. configVo.type .. "_ui"):SetActive(false)
        end
    end
end

--更新工厂状态state="action是进入生产 "stop"是停止
function updateFactoryState(self, args)
    if self.mAnimatorDic[args.type] then
        self.mAnimatorDic[args.type]:SetTrigger(args.state)
        if args.state == "action" then
            if self.mEffectDic[args.type] ~= nil then
                if self.mEffectDic[args.type].effectGo then
                    self.mEffectDic[args.type].effectGo:SetActive(true)
                end
            else
                self.mEffectDic[args.type] = self:addEffect("fx_modelui_miniwork_0" .. args.type, self.mAnimatorDic[args.type].gameObject.transform)
            end
        else
            if self.mEffectDic[args.type] ~= nil then
                if self.mEffectDic[args.type].effectGo then
                    self.mEffectDic[args.type].effectGo:SetActive(false)
                end
            end
        end
    end
end

--更新生产列表按钮显示的内容（列表空，制作中）
function updateProduceBtnTxt(self)
    if #miniFac.MiniFactoryManager:getProduceList() <= 0 then
        self:setProduceBtnTxts(_TT(60516), 0, miniFac.MiniFactoryManager:getOpenModuleNums(), false)
    elseif #miniFac.MiniFactoryManager:getProduceList() > 0 then
        if miniFac.MiniFactoryManager:getCompleteOrderCount() <= 0 then
            self:setProduceBtnTxts(_TT(60517), #miniFac.MiniFactoryManager:getProduceList(), miniFac.MiniFactoryManager:getOpenModuleNums(), false)
        elseif miniFac.MiniFactoryManager:getCompleteOrderCount() > 0 then
            self:setProduceBtnTxts(_TT(44504), miniFac.MiniFactoryManager:getCompleteOrderCount(), miniFac.MiniFactoryManager:getOpenModuleNums(), true)
        end
    end
end

function recoverModelList(self)
    if self.mModelItemList then
        for i = #self.mModelItemList, 1, -1 do
            self.mModelItemList[i]:destroy()
            table.remove(self.mModelItemList, i)
        end
        self.mModelItemList = {}
    end
end

--修改生产列表按钮Txt  state "当前生产状态"   Over "正在生产的订单数量"  ListNum "生产列表数量"
function setProduceBtnTxts(self, State, OverNum, ListNum, IsChengeColor)
    if IsChengeColor then
        self.mTextProduceTip.text = HtmlUtil:color(State, "D7780E")
    else
        self.mTextProduceTip.text = HtmlUtil:color(State, "82898C")
    end
    self.mTextProduce.text = OverNum
    self.mTextListNum.text = "/" .. ListNum
end
--添加3D特效
function addEffect(self, effectName, parentTrans)
    if (effectName) then
        self:removeEffect(effectName)
    end
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)
            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
        else
            if (effectName) then
                self:removeEffect(effectName)
            end
        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:get3DSceneFx("scene/ui_miniwork/" .. string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
    return effectData
end
-- 移除界面3D特效
function removeEffect(self, effectName)
    if (self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if (effectName == nil or effectName == effectData.effectName) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:get3DSceneFx("scene / ui_miniwork /" .. string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                end
            end
        end
        if (effectName == nil) then
            self.mEffectList = {}
        end
    else
        self.mEffectList = {}
    end
end

function recoverAllGrid(self)
    if (self.mTargetGrid) then
        self.mTargetGrid:poolRecover()
    end
    self.mTargetGrid = nil
end
function recoverEffectDic(self)
    if (self.mEffectDic) then
        self.mEffectDic = {}
    end
end
--更新射线检测
function onUpdateRayDetection(self)
    -- 射线检测
    if self.sceneCamera then
        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.sceneCamera, "Building", 500)
        if (hitInfo and hitInfo.collider and guide.GuideManager:getCurHasGuide() == false) then
            local item = hitInfo.collider.gameObject
            local style = string.sub(item.name, #item.name, -1)
            local type = miniFac.MiniFactoryManager:getFactoryDic()[tonumber(style)].type
            if self.mModelItemList[type] then
                self.mModelItemList[type]:onClickHandler()
            else
                gs.Message.Show(_TT(60511))
                return
            end
            --打开工厂面板
        end
    end
end

function onCustomClose(self)
    self.camera = nil
    self:recoverModelList()
end

function destroyPanel(self)
    super.destroyPanel(self)
    self:removeEffect()
    self:recoverEffectDic()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]