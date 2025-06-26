--[[ 
-----------------------------------------------------
@filename       : RoleGuradGroupPanel
@Description    : 预备看板战员组
@date           : 2024-12-17 17:49:45
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleGuradGroupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleGuradGroupPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(41733)) --"值班组"
    -- self:setBg("common_bg_016.jpg", false)
    -- self:setUICode(LinkCode.HomePage)
end
--析构  
function dtor(self)
end

function initData(self)
    -- 是否改变展示类型
    self.isChangeType = nil
end

-- 初始化
function configUI(self)
    self.mGroupTran = self:getChildTrans("mGroup")

    self.mTxtShowSpine = self:getChildGO("mTxtShowSpine"):GetComponent(ty.Text)
    self.mTxtFashion = self:getChildGO("mTxtFashion"):GetComponent(ty.Text)
    self.mToggleSpine = self:getChildGO("mToggleSpine"):GetComponent(ty.Toggle)
    self.mToggleFashion = self:getChildGO("mToggleFashion"):GetComponent(ty.Toggle)
end

--激活
function active(self, args)
    super.active(self, args)
    self:updateView()
    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_WEAR_FASHION, self.updateView, self)


    local type = role.RoleManager:getHeroGroupShowSpine()
    self.mToggleSpine.isOn = type == 1 and true or false
    self.mToggleFashion.isOn = false

    local function onSpineToggle(val)
        self.mToggleFashion.isOn = false
        self.toggleSpine(self)
    end
    self.mToggleSpine.onValueChanged:AddListener(onSpineToggle)

    local function onFashionToggle(val)
        self.toggleFashion(self)
    end
    self.mToggleFashion.onValueChanged:AddListener(onFashionToggle)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverHeroItem()
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })

    GameDispatcher:removeEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_WEAR_FASHION, self.updateView, self)
    self.mToggleSpine.onValueChanged:RemoveAllListeners()
    self.mToggleFashion.onValueChanged:RemoveAllListeners()

    local state = mainui.MainUIManager:getIsShowDynamic()
    if self.mToggleSpine.isOn then
        if state == 0 then

        end
        mainui.MainUIManager:setIsShowDynamic(1)
    else
        mainui.MainUIManager:setIsShowDynamic(0)
    end

    self:changeShowBoard()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtShowSpine.text = _TT(41734)
    self.mTxtFashion.text = _TT(41735)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

-- 同步变化
function changeShowBoard(self)
    if self.isChangeType then
        -- 切换是否动态立绘直接重新设置
        local groupData = role.RoleManager:getHeroGroup()
        for i = 1, 6 do
            local heroId = groupData[tostring(i)]
            if heroId then
                GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_SHOW_BOARD_HERO, { heroId = heroId })
                self.isChangeType = false
                break
            end
        end
    end
end

-- 切换spine
function toggleSpine(self)

    local type = self.mToggleSpine.isOn and 1 or 0
    role.RoleManager:setHeroGroupShowSpine(type)

    self.isChangeType = true
    self:updateHeroItem()
end

-- 切换快捷换装
function toggleFashion(self)
    self:updateHeroFashionState()
end

function updateView(self)
    self:updateHeroItem()
end

function updateHeroItem(self)
    self:recoverHeroItem()
    local groupData = role.RoleManager:getHeroGroup()
    for i = 1, 6 do
        local item = SimpleInsItem:create(self:getChildGO("GroupHeroItem"), self.mGroupTran, "RoleGuradGroupPanelGroupHeroItem")
        item:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
        local heroId = groupData[tostring(i)]
        if heroId then
            local heroVo = hero.HeroManager:getHeroVo(heroId)
            item:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroBodyImgUrl(heroVo:getHeroModel()))
            item:getChildGO("mImgHeroBg"):SetActive(true)
        else
            item:getChildGO("mImgHeroBg"):SetActive(false)
        end
        item:setBtnLabel("mBtnFashion", 41738, "选择换装")
        item:getChildGO("mImgFashion"):SetActive(self.mToggleFashion.isOn)

        item:addUIEvent("mImgBg", function()
            if not self.mToggleFashion.isOn then
                self.mSelectIndex = i
                local id = groupData[tostring(self.mSelectIndex)]
                GameDispatcher:dispatchEvent(EventName.OPEN_HERO_GROUP_SELECT_VIEW, { heroId = id })
            else
                -- gs.Message.Show("请先关闭换装设置")
                gs.Message.Show(_TT(41744))
            end
        end)
        item:addUIEvent("mBtnFashion", function()
            self.mSelectIndex = i
            local id = groupData[tostring(self.mSelectIndex)]
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_GROUP_FASHION_VIEW, { heroId = id })
        end)
        table.insert(self.mHeroItemList, item)
    end
end

function updateHeroFashionState(self)
    local groupData = role.RoleManager:getHeroGroup()
    for k, item in pairs(self.mHeroItemList) do
        local heroId = groupData[tostring(k)]
        if heroId and heroId > 0 then
            item:getChildGO("mImgFashion"):SetActive(self.mToggleFashion.isOn)
        else
            item:getChildGO("mImgFashion"):SetActive(false)
        end
    end
end

function recoverHeroItem(self)
    if self.mHeroItemList then
        for k, v in pairs(self.mHeroItemList) do
            v:poolRecover()
        end
    end
    self.mHeroItemList = {}
end

function onHeroGroupSelectOne(self, args)
    local heroId = args.heroId

    local groupData = role.RoleManager:getHeroGroup()

    for k, v in pairs(groupData) do
        if tonumber(k) ~= self.mSelectIndex and v == heroId then
            -- 把相同的换过来
            local id = groupData[tostring(self.mSelectIndex)]
            groupData[k] = id
        end
        if tonumber(k) == self.mSelectIndex and v == heroId then
            -- 同位置同战员则取消
            heroId = nil
        end
    end
    groupData[tostring(self.mSelectIndex)] = heroId
    role.RoleManager:setHeroGroup(groupData)
    self:updateHeroItem()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]