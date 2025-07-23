module("game.selectedHero.view.SelectedPropsView", Class.impl(selectedHero.SelectedHeroView))

UIRes = UrlManager:getUIPrefabPath("selectedHero/SelectedHero.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1394))
end

function __setContex(self)
    local canSelect = self.m_propsVo.id ~= nil and self.m_propsVo.id ~= 0

    local list = selectedHero.SelectedHeroManager:getDataList()

    -- self.base_childGos["gTxtTitle"]:GetComponent(ty.Text).text = _TT(1394)
    for i = 1, #list do
        local vo = props.PropsManager:getPropsVo({tid = list[i].tid, num = list[i].num})

        local item = selectedHero.SelectedPropsItem:poolGet()

        item:setData(self.mScrollContent, {vo, i, list[i].num, canSelect})

        table.insert(self.itemList, item)
    end

    if #list > 5 then
        gs.TransQuick:Pivot(self.mScrollContent, 0, 1)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 0, 1)
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleLeft
    else
        gs.TransQuick:Pivot(self.mScrollContent, 0.5, 0.5)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 1, 1)
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleCenter
    end

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
