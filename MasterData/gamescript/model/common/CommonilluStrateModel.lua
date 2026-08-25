local function modelState(data)
  local state = {}
  
  state.title = data.title
  state.content = data.content
  state.image = data.image
  state.creationTidList = data.creationTidList
  return state
end

local function modelView(data)
  local view = {}
  
  function view:GetTitle()
    return data.title
  end
  
  function view:GetContent()
    return data.content
  end
  
  function view:GetImage()
    return data.image
  end
  
  function view:GetCreationTidList()
    return data.creationTidList
  end
  
  return view
end

local function modelAction(data)
  local action = {}
  
  function action:SetContent(content)
    data.content = content
  end
  
  function action:SetTitle(title)
    data.title = title
  end
  
  function action:SetImage(image)
    data.image = image
  end
  
  return action
end

local function onSetup(_, _)
end

do return Vue.model("CommonilluStrateModel", modelState):views(modelView):actions(modelAction).setup, (Vue.model("CommonilluStrateModel", modelState):views(modelView):actions(modelAction)) end
return Vue.model("CommonilluStrateModel", modelState):views(modelView):actions(modelAction).setup, Vue.model("CommonilluStrateModel", modelState):views(modelView):actions(modelAction), onSetup
