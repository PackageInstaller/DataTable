--[[ 
-----------------------------------------------------
@filename       : RoleBgView
@Description    : 玩家背景列表面板
@date           : 2022-05-26 20:25:40
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("game.role.view.RoleBgView", Class.impl(View))
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/tab/RoleBgView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0
--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(0, 0)
    --self:setTxtTitle("个性背景")
end
--析构  
function dtor(self)
    super.dtor(self)
end
-- 初始化数据
function initData(self)
    --背景预制体列表
    self.mBgItemList = {}
    --当前展示背景数据
    self.mCurShowBgVo = nil
    --背景数据列表
    self.mBgVoList = {}
    --当前选中背景id
    self.mCurSelectId = 0
    --玩家当前装备的背景id
    self.mCurPlayerId = 0
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mBtnUsing = self:getChildGO("mBtnUsing")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mContentBg = self:getChildTrans("mContentBg")
    self.mBtnCloseAll = self:getChildGO("mBtnCloseAll")
    self.mGroupBgList = self:getChildGO("mGroupBgList")
    self.mBtnChangeBg = self:getChildGO("mBtnChangeBg")
end

--只适配按钮
function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnChangeBg, 25222, "确定更换")
    self:setBtnLabel(self.mBtnGoto, 4033, "获取途径")
    -- self:setBtnLabel(self.mBtnClose, 25221, "取消更换")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.shutView)
    self:addUIEvent(self.mBtnGoto, self.onClickGoToHandler)
    self:addUIEvent(self.mBtnChangeBg, self.onClickChangeBg)
    self:addUIEvent(self.mBtnCloseAll, self.openNavigationLink)
end
--激活
function active(self)
    super.active(self)
    self.mask:SetActive(false)
    GameDispatcher:addEventListener(EventName.UPDATE_PREVIEW_BG, self.updateBgListState, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateReadRed, self)
    GameDispatcher:addEventListener(EventName.SYSTEM_SETTING_NOTCH_CHANGE, self.setAdapta, self)
    self:setAdapta()
    self:updateBgList()
    self:updateInitBg()
    MoneyManager:setMoneyTidList()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_PREVIEW_BG, self.updateBgListState, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateReadRed, self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.CLOSE_PREVIEW_BG)
    self:clearBgList()
end

--更新好友背景列表
function updateBgList(self)
    self:clearBgList()
    self.mBgVoList = role.RoleManager:getBackGroundList()
    for i, vo in pairs(self.mBgVoList) do
        local item = SimpleInsItem:create(self:getChildGO("mGroupBg"), self.mContentBg, "RoleBgViewmGroupBg")
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(vo:getIconLittleUrl(), true)
        item:getChildGO("mTxtBgName"):GetComponent(ty.Text).text = vo:getName()
        local isActive = decorate.DecorateManager:getBackGroundIsActive(vo:getUnLockType())
        item:getChildGO("mLock"):SetActive(isActive == false)
        item:getChildGO("mUnLockTxt"):GetComponent(ty.Text).text = vo:getUnLockDes()
        local isNew = read.ReadManager:isModuleRead(ReadConst.NEW_ROLEBG, vo:getUnLockType())
        item:addUIEvent("mImgBg", function()
            if isNew then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_ROLEBG, id = vo:getUnLockType() })
            end
            if self.mCurSelectId ~= role.RoleManager:getBackGroundIdByIcon(vo.icon) then
                self.mCurSelectId = role.RoleManager:getBackGroundIdByIcon(vo.icon)
                GameDispatcher:dispatchEvent(EventName.UPDATE_PREVIEW_BG, vo.icon)
            end
        end)
        item:setArgs(vo)
        table.insert(self.mBgItemList, item)
    end
    self:updateReadRed()
end

--更新初始背景
function updateInitBg(self)
    local data = role.RoleManager:getPersonalInfoList()
    local index = role.RoleManager:getBackGroundVo(data.background).icon
    self.mCurSelectId = role.RoleManager:getBackGroundIdByIcon(index)
    self.mCurPlayerId = role.RoleManager:getBackGroundIdByIcon(index)
    self:updateBgListState(index)
    self:addTimer(0.1, 0.1, function()
        self:updateBgListState(index)
    end)
end

--更新背景状态
function updateBgListState(self, index)
    local data = role.RoleManager:getPersonalInfoList()
    local curShowIndex = role.RoleManager:getBackGroundVo(data.background).icon
    self.mCurShowBgVo = role.RoleManager:getBackGroundVo(role.RoleManager:getBackGroundIdByIcon(index))
    local isActive = (decorate.DecorateManager:getBackGroundIsActive(self.mCurShowBgVo:getUnLockType()) == true)
    self.mBtnUsing:SetActive(((isActive) and (index == curShowIndex)))
    self.mBtnChangeBg:SetActive(((isActive) and (index ~= curShowIndex)))
    self.mBtnGoto:SetActive(((isActive == false) and (self.mCurShowBgVo:getUicodeId() ~= false)))
    for i, item in ipairs(self.mBgItemList) do
        item:getChildGO("mImgSelect"):SetActive((item:getArgs().icon == index))
        item:getChildGO("mImgDisplay"):SetActive((item:getArgs().icon == curShowIndex))
        local Posx = (item:getArgs().icon == index) and 20 or 0
        gs.TransQuick:LPosX(item:getChildTrans("mGroup").transform, Posx)
    end
end

function updateReadRed(self)
    if #self.mBgItemList > 0 then
        for i, item in ipairs(self.mBgItemList) do
            local isNew = read.ReadManager:isModuleRead(ReadConst.NEW_ROLEBG, item:getArgs():getUnLockType())
            if isNew then
                RedPointManager:add(item:getChildTrans("mImgBg"), nil, -133, 53)
            else
                RedPointManager:remove(item:getChildTrans("mImgBg"))
            end
        end
    end
end

--确认替换背景
function onClickChangeBg(self)
    if self.mCurPlayerId == self.mCurSelectId then
        gs.Message.Show(_TT(73114))
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_SET_DECORATE, { moduleType = decorate.ModuleType.BACKGROUND, id = self.mCurSelectId })
    self:onClickClose()
end
function onClickGoToHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.mCurShowBgVo:getUicodeId() })
    role.RoleManager:setBgIsOpen(true)
    self:onClickClose()
end
--清除背景
function clearBgList(self)
    if self.mBgItemList then
        for _, item in pairs(self.mBgItemList) do
            RedPointManager:remove(item:getChildTrans("mImgBg"))
            item:poolRecover()
        end
        self.mBgItemList = {}
    end
end
-- 打开导航栏
function openNavigationLink(self)
    role.RoleManager:setBgIsOpen(false)
    if not self.mNavigation then
        self.mNavigation = link.NavigationLink:new()
        self.mNavigation:setCloseAllCall(self.closeAll, self)
    end
    self.mNavigation:setParentTrans(self:getChildTrans("mGroupNavigation"), 0)
end

function shutView(self)
    role.RoleManager:setBgIsOpen(false)
    self:onClickClose()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]