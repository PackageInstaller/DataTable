---@class CustomTipsMsgPanel : CustomTipsMsgPanel_Generate
---##################### 【CustomTipsMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CustomTipsMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CustomTipsMsgPanel = require "CustomTipsMsgPanel_Generate"
local CustomTips = require("CustomTips")

 
---@class CustomMsgData
---@field type CustomMsgType          消息类型
---@field config table  配置表
---@field Id integer                     道具|武器|装备ID
---@field LockCallBack function?         锁定回调
---@field CanLock boolean?               是否可以锁定

function CustomTipsMsgPanel:InitLogic(data)

    LuaLogger.ds("CustomTipsMsgPanel  InitLogic data" .. tablex.dump(data))
    self.isDraging = false
    self.lockCallBack = nil

    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"

    ---@type CustomTips
    local lua_customTips = CustomTips:new(self.customTips.gameObject)
    lua_customTips:InitGenerate()
    lua_customTips:setMono(self)
    lua_customTips:SetData(data)
    self.lua_customTips = lua_customTips
end

---@param data CustomMsgData
function CustomTipsMsgPanel:OnOpen(data)

    LuaLogger.ds("CustomTipsMsgPanel data" .. tablex.dump(data))

    self.lockCallBack = data.LockCallBack
    self:SetMaskListener()
    self.closeFunc = data.closeFunc
    
    self.lua_customTips:SetData(data)

    if data.tipsPassEventState == false then
       self:SetPassEventState(false)
    else
        self:SetPassEventState(true)
    end

    if data.disableMaskEvent == true then
        self.mask_Tips:SetActive(false)
    else
        self.mask_Tips:SetActive(true)
    end
end

--设置遮罩监听
function CustomTipsMsgPanel:SetMaskListener()
    local function onPointerClick()
        if not self.isDraging then
            --self.gameObject:SetActive(false)
            UIMgr:closeCurrentUIImmediately(false)
            self.lua_customTips:clearCallBack()
        end
    end
    --遮罩点击关闭自身
    self.mask_Tips.pointerListener.onPointerClickEvent = onPointerClick
end

--设置跳转前的回调
---@param func function 回调函数
function CustomTipsMsgPanel:SetBeforeTruntoFunc(func)
    self.lua_customTips:SetBeforeTruntoFunc(func)
end

--设置是否需要点击穿透
function CustomTipsMsgPanel:SetPassEventState(pass)
    if self.mask_Tips and self.mask_Tips.pointerListener then
        self.mask_Tips.pointerListener.passEvent = pass
    end
end

--[[
/CustomTips/lockBtn onClick 
--]]
function CustomTipsMsgPanel:lockBtn_ScaleButton_onClick(lockBtn)

end

return CustomTipsMsgPanel
