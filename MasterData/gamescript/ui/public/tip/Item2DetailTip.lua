local Item2DetailTip, Super = System.NewComponent("Item2DetailTip", ItemDetailTipBase)

function Item2DetailTip:ctor(uiNode, _, dataSourceType, data)
  Super.ctor(self, uiNode, UI_Awaker_Item_Weapon_TipResource, dataSourceType, data)
end

function Item2DetailTip:OnBind(binder)
  Super.OnBind(self, binder)
  if self.dataSourceType == CommonDefine.ItemDataSourceType.Runtime then
    binder:BindToText(self.ui.Text_Level, function()
      do return LT.Textf, "WeaponRefineLevel" end
      return LT.Textf, "WeaponRefineLevel", self.runtimeData.level
    end)
    binder:BindToRaw(function(_, value)
      local groupStarTransform = self.ui.Group_Star.transform
      local childCount = groupStarTransform.childCount
      for i = 0, childCount - 1 do
        if i < value then
          groupStarTransform:GetChild(i).gameObject:SetActive(true)
        else
          groupStarTransform:GetChild(i).gameObject:SetActive(false)
        end
      end
    end, function()
      return self.runtimeData.level
    end)
    binder:BindToText(self.ui.Text_Desc, function()
      do return SkillUtils.GetWeaponStateDesc, self.runtimeData.tid end
      return SkillUtils.GetWeaponStateDesc, self.runtimeData.tid, self.runtimeData.level
    end)
    binder:BindToText(self.ui.Text_Desc_Sec, function()
      return self.configData.StoryDesc or ""
    end)
    local specialParams = self.configData.SpParam
    local attrConfig = DT.ActorAttrType[specialParams[1]]
    binder:BindToText(self.ui.Text_Prop, function()
      do return LT.Text end
      return LT.Text, attrConfig.Text
    end)
    binder:BindToText(self.ui.Text_Prop_Count, function()
      do return tostring end
      return tostring, specialParams[2]
    end)
    if self.configData.Type == CommonDefine.ItemType.Weapon then
      binder:SetActive(self.ui.Toggle_Lock, false)
    else
      binder:SetZ1Toggle(self.ui.Toggle_Lock, self.runtimeData.locked, true)
      binder:BindToZ1Toggle(self.ui.Toggle_Lock, nil, function(_)
        local protoId = "OnLockItem"
        if self.runtimeData.locked then
          protoId = "OnUnlockItem"
        end
        ProtoManager.Instance:ReqServer("GameRequest", protoId, function(svrData)
          self.runtimeData.locked = svrData
        end, function()
        end, self.runtimeData.uid)
      end)
    end
  end
end

return Item2DetailTip
