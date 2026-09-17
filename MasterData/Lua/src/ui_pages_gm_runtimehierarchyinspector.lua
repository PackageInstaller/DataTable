local this = class("runtimeHierarchyInspector", G_UIPageBase)

function this.methods()
  return {
    onClose = function()
      L_UI:close("runtimeHierarchyInspector")
    end
  }
end

return this
