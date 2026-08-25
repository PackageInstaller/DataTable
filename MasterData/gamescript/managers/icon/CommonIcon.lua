local CommonIcon, Super = NewClass("CommonIcon", MaterialIconBase)

function CommonIcon:ctor(container)
  Super.ctor(self, container)
  self.ui = Icon_CommonResource(container.gameObject)
end

return CommonIcon
