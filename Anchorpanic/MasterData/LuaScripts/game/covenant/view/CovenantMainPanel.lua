--[[ 
-----------------------------------------------------
@filename       : ConvenantMainPanel
@Description    : 盟约主界面
@date           : 2021-06-15 14:12:00
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("covenant.CovenantMainPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52018))
    self:setBg("", false)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.bindBtnDic = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLvTxt = self:getChildGO("LvTxt"):GetComponent(ty.Text)
    self.mForcesNameTxt = self:getChildGO("ForcesNameTxt"):GetComponent(ty.Text)
    self.mSliderBg = self:getChildGO("SliderBG"):GetComponent(ty.RectTransform)
    self.mSlider = self:getChildGO("Slider"):GetComponent(ty.RectTransform)
    self.mReqTxt = self:getChildGO("ReqTxt"):GetComponent(ty.Text)
    self.mTaskBtn = self:getChildGO("mTaskBtn")
    -- cb3屏蔽
    self.mTaskBtn:SetActive(false)

    self.mShopBtn = self:getChildGO("mShopBtn")
    self.mSkillBtn = self:getChildGO("mSkillBtn")
    -- self.mGraduateSchoolBtn = self:getChildGO("mGraduateSchoolBtn")
    self.GraduateSchoolLv = self:getChildGO("GraduateSchoolLv"):GetComponent(ty.Text)
    self.mExploreBtn = self:getChildGO("mExploreBtn")
    self.mHQBtn = self:getChildGO("mHQBtn")

    self.mRoot = self:getChildTrans("Root")

    self.mClickTouch = self:getChildGO("mClickTouch"):GetComponent(ty.LongPressOrClickEventTrigger)

    local function _onPointerUpHandler()
        covenant.CovenantMainCamera:setMouseUp()
    end
    self.mClickTouch.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onPointerDownHandler()
        covenant.CovenantMainCamera:setMouseDown()
    end
    self.mClickTouch.onPointerDown:AddListener(_onPointerDownHandler)

    local function _onScrollHandler()
        covenant.CovenantMainCamera:setOnScroll()
    end
    self.mClickTouch.onScroll:AddListener(_onScrollHandler)
    
end

-- 激活
function active(self)
    super.active(self)

    self:updateBindOpt()
    -- gs.CameraMgr:SetUICameraProjetion(false, 1)
    GameDispatcher:addEventListener(EventName.UPDATE_COVENANT_REDPOINT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    explore.exploreManager:addEventListener(explore.exploreManager.EVENT_DATA_UPDATE, self.onFuncOpenUpdateHandler, self)
    covenant.CovenantManager:addEventListener(covenant.CovenantManager.EVENT_INSTITUTE_UPDATE, self.onUpdateHandler, self)
    covenant.CovenantManager:addEventListener(covenant.CovenantManager.EVENT_FORCES_UPDATE, self.onUpdateHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
    self:initView()
    self:onFuncOpenUpdateHandler()

    self:setGuideTrans("guide_CovenantMain_Task", self.mTaskBtn.transform)

    self:updateUI()

    -- if guide.GuideManager:getCurHasGuide() == true then
    --     self.mClickTouch.gameObject:SetActive(false)
    -- else
    --     self.mClickTouch.gameObject:SetActive(false)
    -- end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    -- gs.CameraMgr:SetUICameraProjetion(true, 1)
    self:customRemoveRedPoint()
    GameDispatcher:removeEventListener(EventName.UPDATE_COVENANT_REDPOINT, self.onFuncOpenUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.FUNC_OPEN_DATA_INIT, self.onFuncOpenUpdateHandler, self)
    explore.exploreManager:removeEventListener(explore.exploreManager.EVENT_DATA_UPDATE, self.onFuncOpenUpdateHandler, self)
    covenant.CovenantManager:removeEventListener(covenant.CovenantManager.EVENT_INSTITUTE_UPDATE, self.onUpdateHandler, self)
    covenant.CovenantManager:removeEventListener(covenant.CovenantManager.EVENT_FORCES_UPDATE, self.onUpdateHandler, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mShopBtn.transform:Find("mTxtFunc"):GetComponent(ty.Text).text = _TT(29564)
    self.mSkillBtn.transform:Find("mTxtFunc"):GetComponent(ty.Text).text = _TT(29565)
    -- self.mGraduateSchoolBtn.transform:Find("mTxtFunc"):GetComponent(ty.Text).text = _TT(29566)
    self.mExploreBtn.transform:Find("mTxtFunc"):GetComponent(ty.Text).text = _TT(29562)
    self.mHQBtn.transform:Find("mTxtFunc"):GetComponent(ty.Text).text = _TT(29563)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- if guide.GuideManager:getCurHasGuide() == false then
    --     for _, v in pairs(self.bindBtnDic) do
    --         self:addUIEvent(v.btn, self.onClickHandler, nil, v)
    --     end
    -- end

    self:addUIEvent(self.mTaskBtn, self.mTaskBtnClick)
end

function updateBindOpt(self)
    self.bindBtnDic = {}
    self:addBindPosBtn(self.mShopBtn, LinkCode.CovenantShop, covenant.PosConst.Shop)
    self:addBindPosBtn(self.mSkillBtn, LinkCode.CovenantSkill, covenant.PosConst.Skill)
    -- self:addBindPosBtn(self.mGraduateSchoolBtn, LinkCode.CovenantGraduateSchool, covenant.PosConst.GraduateSchool)
    self:addBindPosBtn(self.mExploreBtn, LinkCode.CovenantExplore, covenant.PosConst.Explore)
    self:addBindPosBtn(self.mHQBtn, LinkCode.CovenantHeadQuarter, covenant.PosConst.HQ)
end

function addBindPosBtn(self, btn, linkCode, posConst)
    local bindPos = gs.GameObject.Find("scene_root_ui_covenant/environment/Pos" .. posConst).transform.position
    self.bindBtnDic[posConst] = { btn = btn, linkCode = linkCode, posName = posConst, bindPos = bindPos }

    if guide.GuideManager:getCurHasGuide() == true then
       
        local guideTrans = self:getChildTrans("mGuide_" .. linkCode)
        self:addUIEvent(guideTrans.gameObject, self.onClickHandler, nil, self.bindBtnDic[posConst])
        self:setGuideTrans("guide_CovenantMain_" .. linkCode, guideTrans)
    end
end

function onUpdateHandler(self)
    self:initView()
end

function initView(self)
    self.cusId = covenant.CovenantManager:getForcesId()
    self.cusLevel = covenant.CovenantManager:getPerstigeStage()
    self.mLvTxt.text = self.cusLevel
    self.GraduateSchoolLv.text = covenant.CovenantManager:getInstituteServerInfo().lv
    self.cusPeq = covenant.CovenantManager:getPrestigeExp()
    local levelData = covenant.CovenantManager:getCovenantPrestigeDataById(self.cusLevel)

    local value = gs.Mathf.Clamp(self.cusPeq / levelData.next_exp * self.mSliderBg.sizeDelta.x - 5, 0, 1)
    gs.TransQuick:SizeDelta01(self.mSlider, value)
    self.mReqTxt.text = self.cusPeq .. "/" .. levelData.next_exp

    self.data = covenant.CovenantManager:getCovenantSelectData(self.cusId)
    if not self.data then
        return
    end
    self.mForcesNameTxt.text = _TT(self.data.name)
end

-- 更新红点信息
function __updateRedPoint(self)
    if covenant.CovenantManager:getLevelRedPoint() then
        RedPointManager:add(self.mHQBtn.transform, nil, 76.5, 14)
    else
        RedPointManager:remove(self.mHQBtn.transform)
    end

    if covenant.CovenantManager:getTaskRed() then
        RedPointManager:add(self.mTaskBtn.transform, nil, 122, 25)
    else
        RedPointManager:remove(self.mTaskBtn.transform)
    end

    if explore.exploreManager:getExploreRed() then
        RedPointManager:add(self.mExploreBtn.transform, nil, -75, 12.5)
    else
        RedPointManager:remove(self.mExploreBtn.transform)
    end
    -- if covenant.CovenantManager:getInstituteRed() then
    --     RedPointManager:add(self.mGraduateSchoolBtn.transform, nil, 71, 11)
    -- else
    --     RedPointManager:remove(self.mGraduateSchoolBtn.transform)
    -- end
end

function customRemoveRedPoint(self)
    RedPointManager:remove(self.mHQBtn.transform)
    RedPointManager:remove(self.mTaskBtn.transform)
    RedPointManager:remove(self.mExploreBtn.transform)
end

function __updateLock(self)
    for _, v in pairs(self.bindBtnDic) do
        local configVo = link.LinkManager:getLinkData(v.linkCode)
        if not configVo then
            logError(string.format("uicode%s没有配置，找策划哥", v.linkCode))
            return
        end

        if configVo.funcOpenId > 0 then
            local isOpen = funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, false)
            v.btn.transform:Find("Lock").gameObject:SetActive(not isOpen)
        end
    end
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

function updateUI(self)
    if self.camera == nil then
        self.camera = covenant.CovenantMainCamera:getCamera()
    end

    for _, v in pairs(self.bindBtnDic) do
        local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetToScreenSceneCamera(), gs.CameraMgr:GetUICamera(), v.bindPos, self.mRoot, nil)
        gs.TransQuick:UIPos(v.btn.transform, pos.x, pos.y)
    end
end

function canRay(self)
    if self.camera == nil then
        self.camera = covenant.CovenantMainCamera:getCamera()
    end

    if guide.GuideManager:getCurHasGuide() == true then
        return false
    end

    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "RealLight", 500)
    if hitInfo and hitInfo.collider then
        local item = hitInfo.collider.gameObject
        local const = string.sub(item.name, #item.name, -1)
        self.lastConst = tonumber(const)
        return true
    else
        return false
    end
end

function clickRay(self)
    self:onClickHandler(self.bindBtnDic[tonumber(self.lastConst)])
end

-- 更新势力红点
function onFuncOpenUpdateHandler(self)
    self:__updateRedPoint()
    self:__updateLock()
end

function mTaskBtnClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.CovenantTask })
end

function onClickHandler(self, data)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = data.linkCode})
    if self.camera == nil or self.hasEvent == true then
        return
    else
        self.UIBase:SetActive(false)
        self.lastPos = gs.Vector3(self.camera.transform.position.x, self.camera.transform.position.y, self.camera.transform.position.z)
        self.lastRot = gs.Vector3(self.camera.transform.rotation.eulerAngles.x, self.camera.transform.rotation.eulerAngles.y, self.camera.transform.rotation.eulerAngles.z)
        covenant.CovenantMainCamera:setIsMoving(true)
        self.hasEvent = true
        local focusTran = gs.GameObject.Find("scene_root_ui_covenant/environment/FocusPos" .. data.posName).transform
        local function addEff()
            local function _loadAysnCall(effectGo)
                self.effectGo = effectGo
                gs.TransQuick:SetParentOrg(effectGo.transform, GameView.subPop)
            end
            self.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", "CovenantTransitionPanel")), _loadAysnCall)
        end

        local function removeEff()
            gs.GOPoolMgr:CancelAsyc(self.effectSn)
            if self.effectGo then
                if (not gs.GoUtil.IsGoNull(self.effectGo)) then
                    gs.GOPoolMgr:Recover(self.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", "CovenantTransitionPanel")))
                end
              
                ---   gs.GameObject.Destroy(self.effectGo)
            end
        end
        if data.posName == covenant.PosConst.Shop or data.posName == covenant.PosConst.Explore or data.posName == covenant.PosConst.Skill then
            LoopManager:setTimeout(0.5, nil, addEff)
            LoopManager:setTimeout(1.5, nil, removeEff)

        end
        TweenFactory:move2pos(self.camera.transform, focusTran.position, 1, nil, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = data.linkCode })
            if self.camera and data.posName == covenant.PosConst.Shop or data.posName == covenant.PosConst.Explore or data.posName == covenant.PosConst.Skill then
                self.camera.gameObject:SetActive(false)
            end
        end)
        TweenFactory:rotate(self.camera.transform, focusTran.rotation.eulerAngles, 1)
    end
end

function onCustomClose(self)
    TweenFactory:move2pos(self.camera.transform, self.lastPos, 1, nil, function()
        covenant.CovenantMainCamera:setIsMoving(false)
        self.UIBase:SetActive(true)
        self.hasEvent = false
        self:updateUI()
    end)
    if self.camera == nil then
        self.camera = covenant.CovenantMainCamera:getCamera()
    end
    self.camera.gameObject:SetActive(true)
    TweenFactory:rotate(self.camera.transform, self.lastRot, 1)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
