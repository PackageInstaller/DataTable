local CommonIconObsolete, Super = NewClass("CommonIconObsolete", MaterialIconBaseObsolete)

function CommonIconObsolete:ctor(container)
  Super.ctor(self, container)
  self.ui = Icon_CommonResource(container.gameObject)
end

return CommonIconObsolete
