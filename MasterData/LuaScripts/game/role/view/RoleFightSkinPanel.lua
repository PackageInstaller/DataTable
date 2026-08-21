--[[ 
-----------------------------------------------------
@Description    : 联盟团战主界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("role.RoleFightSkinPanel", Class.impl(View))
-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleFightSkinPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(153003))

    self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnPre = self:getChildGO("mBtnPre")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
    self.mLyScroller = self:getChildGO("mSkinScroll"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(role.FightSkinItem)

    self.mImgUsing = self:getChildGO("mImgUsing")
    self.mTxtUsing = self:getChildGO("mTxtUsing"):GetComponent(ty.Text)

    self.mToggleRandom = self:getChildGO("mToggleRandom"):GetComponent(ty.Toggle)
    self.mTxtRandom = self:getChildGO("mTxtRandom"):GetComponent(ty.Text)

    self.mToggleRandom.onValueChanged:AddListener(function ()
         StorageUtil:saveBool0(gstor.RANDOM_FIGHT_SKIN, self.mToggleRandom.isOn)
    end)
end

function initViewText(self)
    self.mTxtUsing.text = _TT(25194)
    self.mTxtRandom.text = _TT(153009)
        self:setBtnLabel(self.mBtnPre, 153005, "预览")
    self:setBtnLabel(self.mBtnSelect, 153006, "装扮")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.shopPanel, self)
    GameDispatcher:addEventListener(EventName.CHANGE_FIGHT_SKIN_SELECT,self.onChangeSelect,self)
    GameDispatcher:addEventListener(EventName.UPDATE_FIGHT_SKIN_CHANGE,self.onChangeCur,self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.shopPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    GameDispatcher:removeEventListener(EventName.CHANGE_FIGHT_SKIN_SELECT,self.onChangeSelect,self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FIGHT_SKIN_CHANGE,self.onChangeCur,self)

   
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPre, self.onClickPre)
    self:addUIEvent(self.mBtnSelect, self.onClickSelect)
end


function onClickPre(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_SKIN_PRE_VIEW, self.tempSelect)
end

function onClickSelect(self)
    if role.RoleManager:getFightSkinIsLock(self.tempSelect) then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI,{ linkId = LinkCode.ShopFight })
        return
    end

    role.RoleManager:setTempSelectSkin(self.tempSelect)
    GameDispatcher:dispatchEvent(EventName.REQ_SET_DECORATE, {moduleType = decorate.ModuleType.FIGHTSKIN, id = self.tempSelect})
    --GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_FIGHT_SKIN, self.tempSelect)
end

function onChangeCur(self)
    local fightSkinData = self.mLyScroller.DataProvider
    self.mLyScroller:ReplaceAllDataProvider(fightSkinData)
    self:updateIsLockState()
end

function onChangeSelect(self,id)
    --临时选中id
    self.tempSelect = id
    local fightSkinData = self.mLyScroller.DataProvider
    for i = 1, #fightSkinData, 1 do
        fightSkinData[i].isSelect = fightSkinData[i].id == self.tempSelect
    end
    self.mLyScroller:ReplaceAllDataProvider(fightSkinData)

    self:updateIsLockState()
end

function updateIsLockState(self)

    self.mIsRandom = StorageUtil:hasKey0(gstor.RANDOM_FIGHT_SKIN) and StorageUtil:getBool0(gstor.RANDOM_FIGHT_SKIN) == true
    self.mToggleRandom.isOn = self.mIsRandom

    self:setBtnLabel(self.mBtnSelect, not role.RoleManager:getFightSkinIsLock(self.tempSelect) and 153006 or 151019 ,"装扮")

    local curSkinId = role.RoleManager:getServerFightSkinId()
    self.mImgUsing:SetActive(curSkinId ==self.tempSelect)
    self.mBtnSelect:SetActive(curSkinId ~=self.tempSelect)
end

function showPanel(self)
    self.tempSelect = role.RoleManager:getServerFightSkinId()
    local fightSkinData = role.RoleManager:getFightSkinData()
    for i = 1, #fightSkinData, 1 do
        fightSkinData[i].isSelect = fightSkinData[i].id == self.tempSelect
        fightSkinData[i].isLock = role.RoleManager:getFightSkinIsLock(fightSkinData[i].id) and 1 or 0
    end

    table.sort(fightSkinData, function(a, b)
        if a.isLock == b.isLock then
            return a.id < b.id
        end
        return a.isLock < b.isLock
    end)

    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = fightSkinData
    else
        self.mLyScroller:ReplaceAllDataProvider(fightSkinData)
    end

    self:updateIsLockState()
end

return _M
