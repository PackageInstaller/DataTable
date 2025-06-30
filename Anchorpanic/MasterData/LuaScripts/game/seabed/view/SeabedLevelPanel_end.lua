

module("seabed.SeabedLevelPanel_end", Class.impl(seabed.SeabedLevelPanel))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedLevelPanel_end.prefab")


function showPanel(self)
    self:clearLevelItems()
    local difficultyList = seabed.SeabedManager:getSeabedDifficultyData()
    for i = 1, #difficultyList do
        local item = SimpleInsItem:create(self.mLevelItem, self.mLevelScroll.content, "mSeabedLevelItem")
        local isLock = seabed.SeabedManager:getDifficultyIsLock(difficultyList[i].id)
        local tips = _TT(self:getDifTiple(difficultyList[i].id))

        item:getChildGO("mTxtTips"):GetComponent(ty.Text).text =
            isLock and _TT(4062) or tips
        item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = tips
        item:getChildGO("mTxtTips"):GetComponent(ty.Text).color =
            isLock and gs.ColorUtil.GetColor("478798FF") or gs.ColorUtil.GetColor("7FB3BEFF")
        item:getChildGO("mIsLock"):SetActive(isLock)

        item:getChildGO("mLevelClick"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPackPath(isLock and "seabed/dif_lock_end.png" or "seabed/dif_def_end.png", false))

        item:addUIEvent("mLevelClick", function()
            self:onClickLevelItem(difficultyList[i].id)
        end)
        table.insert(self.mLevelItems, item)
    end
end

return  _M