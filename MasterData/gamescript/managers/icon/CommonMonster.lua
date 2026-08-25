local CommonMonster, Super = NewClass("CommonMonster", MonsterIconBase)

function CommonMonster:ctor(container)
  Super.ctor(self, container)
  self.ui = UI_Chapter_Item_MonsterResource(container.gameObject)
end

return CommonMonster
