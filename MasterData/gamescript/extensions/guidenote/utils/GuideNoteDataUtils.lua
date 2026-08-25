local GuideNoteDataUtils = {}

function GuideNoteDataUtils.OpenMainView(defaultPage, extraParams)
  local params = {defaultPage = defaultPage}
  if type(extraParams) == "table" then
    for k, v in pairs(extraParams) do
      params[k] = v
    end
  end
  local view = UIManager.Instance:GetWindow(Urls.GuideNoteMainView)
  if view then
    view.closeWithoutAnim = true
  end
  UIManager.Instance:Reopen(Urls.GuideNoteMainView, params)
end

return GuideNoteDataUtils
