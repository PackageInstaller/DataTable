--[[   
    系统设置
]]
module("role.OtherSettingTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("systemSetting/OtherSettingTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

    self.mSettingItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mTxtOpenWallpaperTitle = self:getChildGO("mTxtOpenWallpaperTitle"):GetComponent(ty.Text)

    self.mSettingToggle = self:createToggle1(self:getChildGO("mSettingToggle"))

    self.mItemWallpaperTense = self:getChildGO("mItemWallpaperTense")
    self.mItemWallpaperNeedTime = self:getChildGO("mItemWallpaperNeedTime")
    self.mItemWallpaperRandomTime = self:getChildGO("mItemWallpaperRandomTime")

    self.mItemToggle = self:getChildGO("mItemToggle")
    self.mItemToggle:SetActive(false)

    self.mBtnExchange = self:getChildGO("mBtnExchange")
end

function active(self)
    super.active(self)

    self.mBtnExchange:SetActive((not GameManager:getIsInCommiting() and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_EXCHANGE_CODE, false)))

    self:updateView()

end


function deActive(self)
    super.deActive(self)

    for _, v in pairs(self.mSettingItemList) do
        v:destroy()
    end
    self.mSettingItemList = {}
end

function initViewText(self)
    self.mTxtOpenWallpaperTitle.text = _TT(72118) --"启用待机模式"
end

function addAllUIEvent(self)
    self.mSettingToggle.notifyEvent = function(value)
        systemSetting.SystemSettingManager:setSystemSettingValue(systemSetting.SystemSettingDefine.wallpaperState, tonumber(value))
    end

    self:addUIEvent(self.mBtnExchange, self.onOpenExchangeCodeView)
end

function removeAllUIEvent(self)
    self.mSettingToggle:destroy()
end

function onOpenExchangeCodeView(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_EXCHANGE_CODE_VIEW)
end

function updateView(self)
    for i = 1, #systemSetting.OtherSettingDrop do
        local value = systemSetting.OtherSettingDrop[i]
        local key = value.key
        local toggle = nil
        if key == systemSetting.SystemSettingDefine.wallpaperTense then
            toggle = self:createToggle(self.mItemWallpaperTense, value.title)
            table.insert(self.mSettingItemList, toggle)
            toggle:AddOptions(value.label)
        end
        if key == systemSetting.SystemSettingDefine.wallpaperNeedTime then
            toggle = self:createToggle(self.mItemWallpaperNeedTime, value.title)
            table.insert(self.mSettingItemList, toggle)
            toggle:AddOptions(value.label)
        end
        if key == systemSetting.SystemSettingDefine.wallpaperRandomTime then
            toggle = self:createToggle(self.mItemWallpaperRandomTime, value.title)
            table.insert(self.mSettingItemList, toggle)
            toggle:AddOptions(value.label)
        end


        local valueUpate = function(value)
            systemSetting.SystemSettingManager:setSystemSettingValue(key, tonumber(value))
        end
        toggle.notifyEvent = valueUpate

        local val = systemSetting.SystemSettingManager:getSystemSettingValue(key)
        if val then
            toggle:setValueWithNoNotify(val)
        end
    end

    self.mSettingToggle.setValueWithNoNotify(systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.wallpaperState))
end


---只有两个选项的复选按钮
function createToggle1(self, go)
    local toggle = {}
    toggle.m_go = go
    toggle.m_childGos, toggle.m_childTrans = GoUtil.GetChildHash(toggle.m_go)

    toggle.value = 1
    local click = function()
        local val = toggle.value == 1 and 2 or 1
        toggle.setValueWithOutNotify(val)
    end
    self:addUIEvent(toggle.m_childGos["mClick"], click)

    toggle.setValueWithNoNotify = function(val)
        toggle.value = val
        toggle.show(val == 2)
    end

    toggle.setValueWithOutNotify = function(val)
        toggle.value = val
        toggle.show(val == 2)
        if toggle.notifyEvent then
            toggle.notifyEvent(toggle.value)
        end
    end

    toggle.show = function(val)
        toggle.m_childGos["mTxtClose"]:GetComponent(ty.Text).text = _TT(62064)
        toggle.m_childGos["mTxtOpen"]:GetComponent(ty.Text).text = _TT(62063)
        toggle.m_childGos["mGroupOpen"]:SetActive(val)
        toggle.m_childGos["mGroupClose"]:SetActive(not val)
    end

    toggle.destroy = function()

    end

    return toggle
end

--获取一个新的多选toggle
function createToggle(self, go, title)
    local toggle = {}
    toggle.go = go
    toggle.m_childGos, toggle.m_childTrans = GoUtil.GetChildHash(go)

    toggle.m_childGos["mTxt_title"]:GetComponent(ty.Text).text = title

    toggle.mGroupItems = toggle.m_childTrans["mGroupItems"]

    toggle.value = 1
    toggle.CreateOptionItems = function(_toggle)
        if not _toggle.items then
            _toggle.items = {}
        end
        for i = 1, #_toggle.options do
            if _toggle.items[i] == nil then
                local item = SimpleInsItem:create(self.mItemToggle, _toggle.mGroupItems, self.__cname .. "toggleItem")
                item:setText("mTxtToggle", nil, toggle.options[i])
                item.show = function(_item, value)
                    _item:getChildGO("mImg"):SetActive(value)
                    _item:getChildGO("mBackground"):SetActive(not value)
                end

                local function toggleCall()
                    _toggle:setValueWithOutNotify(i)
                end
                item:addUIEvent("mClickAre", toggleCall)

                _toggle.items[i] = item
            else
                _toggle.items[i]:setActive(true)
            end
        end
    end
    --重新添加选项
    toggle.AddOptions = function(_toggle, options)
        if _toggle.items then
            if #_toggle.items > #options then
                for i = #options, #_toggle.items do
                    _toggle.items[i]:setActive(false)
                end
            end
        end

        _toggle.options = options
        _toggle:CreateOptionItems()
        _toggle:setValueWithNoNotify(_toggle.value)
    end
    --添加单个选项
    toggle.AddOption = function(_toggle, option)
        if not _toggle.options then
            _toggle.options = {}
        end

        table.insert(_toggle.options, option)
        _toggle:CreateOptionItems()
    end

    --不回调事件
    toggle.setValueWithNoNotify = function(_toggle, value)
        if value <= 0 then
            value = 1
        elseif value > #_toggle.options then
            value = #_toggle.options
        end

        _toggle.value = value
        _toggle:show()
    end

    --回调事件
    toggle.setValueWithOutNotify = function(_toggle, value)
        if value <= 0 then
            value = 1
        elseif value > #_toggle.options then
            value = #_toggle.options
        end

        _toggle.value = value
        _toggle:show()

        if _toggle.notifyEvent then
            _toggle.notifyEvent(_toggle.value)
        end
    end

    toggle.show = function(_toggle)
        for i = 1, #_toggle.items do
            _toggle.items[i]:show(i == _toggle.value)
        end
    end
    toggle.destroy = function(_toggle)
        for i = 1, #_toggle.items do
            _toggle.items[i]:removeAllUIEvent()
            _toggle.items[i]:poolRecover()
        end
    end

    return toggle
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]