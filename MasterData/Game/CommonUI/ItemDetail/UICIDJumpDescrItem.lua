local UICIDJumpDescrItem = class("UICIDJumpDescrItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local JumpStrBuilder = require("Game.Jump.JumpStrBuilder")
local lockColor = Color.New(0.1098039, 0.1098039, 0.1098039, 0.8)
local normalColor = Color.New(0.1098039, 0.1098039, 0.1098039, 1)

function UICIDJumpDescrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnBtnGotoClick)
end

function UICIDJumpDescrItem:InitCIDJumpDescrItem(jumpCfg, jumpId, arg)
  local jumpDes = JumpStrBuilder.GetDes(jumpId, arg, LanguageUtil.GetLocaleText(jumpCfg.content))
  self.ui.texInfo_DropInfo:SetIndex(0, jumpDes)
  self.ui.tex_btnName:SetIndex(0)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(jumpCfg.sys_open_id)
  local isJumpUnlock, unlcokNotice
  if isUnlock then
    isJumpUnlock, unlcokNotice = JumpManager.ValidateFuncArray[jumpId](arg, true)
    isUnlock = isJumpUnlock
  end
  self.ui.obj_Lock:SetActive(not isUnlock)
  self.ui.tex_UnlockInfo.gameObject:SetActive(not isUnlock)
  if not isUnlock then
    if isJumpUnlock == false then
      if unlcokNotice == nil then
        self.ui.tex_UnlockInfo.gameObject:SetActive(false)
      else
        self.ui.tex_UnlockInfo.gameObject:SetActive(true)
        self.ui.tex_UnlockInfo.text = unlcokNotice
      end
    else
      self.ui.tex_UnlockInfo.gameObject:SetActive(true)
      self.ui.tex_UnlockInfo.text = FunctionUnlockMgr:GetFuncUnlockDecription(jumpCfg.sys_open_id, true)
    end
    self.ui.tex_DropInfo.color = lockColor
  else
    self.ui.tex_DropInfo.color = normalColor
  end
  self.ui.btn_Goto.gameObject:SetActive(isUnlock)
  self:SetJumpCallback(function()
    local couldJump = JumpManager:ValidateJump(jumpId, arg)
    if couldJump then
      JumpManager:Jump(jumpId, function(jumpCallback)
        local win = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
        if win ~= nil then
          win:OnBtnReturnClick()
        end
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, arg)
    end
  end)
end

function UICIDJumpDescrItem:InitCIDJumpDescrItem4Factory(targetOrderData)
  local roomIndex = targetOrderData:GetOrderRoomIndex()
  local roomName = LanguageUtil.GetLocaleText(ConfigData.factory[roomIndex].name)
  self.ui.texInfo_DropInfo:SetIndex(1, roomName)
  self.ui.tex_btnName:SetIndex(1)
end

function UICIDJumpDescrItem:InitJump2Buy()
  self.ui.texInfo_DropInfo:SetIndex(2)
  self.ui.tex_btnName:SetIndex(2)
end

function UICIDJumpDescrItem:InitUseGift()
  self.ui.texInfo_DropInfo:SetIndex(3)
  self.ui.tex_btnName:SetIndex(3)
end

function UICIDJumpDescrItem:InitFragConvert()
  self.ui.texInfo_DropInfo:SetIndex(4)
  self.ui.tex_btnName:SetIndex(4)
end

function UICIDJumpDescrItem:SetJumpCallback(callback)
  self.jumpCallback = callback
end

function UICIDJumpDescrItem:OnBtnGotoClick()
  if self.jumpCallback ~= nil then
    self.jumpCallback(self.id)
    return
  end
end

return UICIDJumpDescrItem
