local WeaponRefineMaterial, Super = System.NewComponent("WeaponRefineMaterial")

function WeaponRefineMaterial:ctor(go, mtrl, removeCallback)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.mtrl = mtrl
  self.removeCallback = removeCallback
end

function WeaponRefineMaterial:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.mtrl.tid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local config = DT.Item[self.mtrl.tid]
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
  binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, function()
  end, function()
    if self.removeCallback then
      self.removeCallback()
    end
  end, tonumber(DT.GetConstant("ItemAddPressTime")))
  binder:SetActive(self.ui.Group_Refine_Level, false)
  local itemCfg = ItemDataUtils.GetItemConfig(self.mtrl.tid)
  if itemCfg.Type == "Weapon" then
    self.ui.Group_Stars:SetActive(true)
    self.ui.Text_Article_Number:SetActive(false)
    binder:BindToRaw(function(childBinder, level)
      local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
      local numStars = math.min(level, refineStage1MaxLevel)
      for i = 1, 5 do
        local obj = self.ui["Star_" .. i]
        if obj then
          childBinder:SetActive(obj, i <= numStars)
        end
      end
      if level > refineStage1MaxLevel then
        self.ui.Image_Max:SetActive(true)
        childBinder:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
      else
        self.ui.Image_Max:SetActive(false)
      end
    end, function()
      return self.mtrl.level
    end)
  else
    self.ui.Group_Stars:SetActive(false)
    self.ui.Text_Article_Number:SetActive(true)
    binder:BindToText(self.ui.Text_Article_Number, function()
      local totalNum = ItemDataUtils.GetItemByUid(self.mtrl.uid).num
      return self.mtrl.num .. "/" .. totalNum
    end)
  end
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, function()
    ItemDataUtils.ShowItemDetailTips(binder, self.ui.uiNode, self.mtrl.uid, self.mtrl.tid, nil, nil, function(lockState)
    end)
  end, tonumber(DT.GetConstant("Role_Press_Time")))
end

return WeaponRefineMaterial
