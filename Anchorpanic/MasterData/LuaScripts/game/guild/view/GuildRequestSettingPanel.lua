--[[ 
-----------------------------------------------------
@filename       : GuildReNamePanel
@Description    : 联盟改名界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("guild.GuildRequestSettingPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guild/GuildRequestSettingPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(834, 334)
    self:setTxtTitle(_TT(94542))
end

-- 适应全面屏，刘海缩进
function setAdapta(self)

end

function initData(self)
    self.toggleList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mToggleGroup = self:getChildGO("mToggleGroup")
    self.mToggle1 = self:getChildGO("mToggle1"):GetComponent(ty.Toggle)
    self.mToggle2 = self:getChildGO("mToggle2"):GetComponent(ty.Toggle)
    self.mToggle3 = self:getChildGO("mToggle3"):GetComponent(ty.Toggle)

    table.insert(self.toggleList, self.mToggle1)
    table.insert(self.toggleList, self.mToggle2)
    table.insert(self.toggleList, self.mToggle3)

    self.mInputFieldLv = self:getChildGO("mInputFieldLv"):GetComponent(ty.InputField)

    -- local function inputChange(value)
       
    --     local currentLv = tonumber(value)
    --     if currentLv ~= nil then
    --         cusLog("这个判断111")
    --         if currentLv > maxLv then
    --             self.mInputFieldLv.text = maxLv
    --         elseif currentLv < 1 then
    --             self.mInputFieldLv.text = "1"
    --         end
    --     end
    -- end
    -- self.mInputFieldLv.onValueChanged:AddListener(inputChange)
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
end

function initViewText(self)
    -- self.mScoreTitle.text = _TT(44657) --"EMAIL LIST"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.close)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirm)
end

function onClickConfirm(self)
    local type = 1
    for i = 1, #self.toggleList do
        if self.toggleList[i].isOn == true then
            type = i
        end
    end

    local value = self.mInputFieldLv.text
    if not value or value == "" then
        gs.Message.Show(_TT(94520))
        return
    end

    local maxLv = role.RoleManager:getMaxRoleLv()
    if tonumber(self.mInputFieldLv.text) > maxLv or tonumber(self.mInputFieldLv.text) < 1 then
        gs.Message.Show(_TT(94520))
        return
    end

    cusLog(type)
    GameDispatcher:dispatchEvent(EventName.REQ_SET_APPLY_COND, {
     
        type = type,
        lv = self.mInputFieldLv.text
    })
end
-- 激活
function active(self, args)
    super.active(self, args)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
end

function showPanel(self)
    self.guildInfo = guild.GuildManager:getGuildInfo()

    for i = 1, #self.toggleList do
        self.toggleList[i].isOn = self.guildInfo.apply_type == i
    end
    self.mInputFieldLv.text = self.guildInfo.apply_lv_cond
end

return _M
