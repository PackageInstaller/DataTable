local IBattleCardUIDelegate = System.NewInterface("IBattleCardUIDelegate")

function IBattleCardUIDelegate:GetCardContent()
end

function IBattleCardUIDelegate:GetDrawDeckBtn()
end

function IBattleCardUIDelegate:GetGraveyardDeckBtn()
end

function IBattleCardUIDelegate:GetHandDeckBtn()
end

function IBattleCardUIDelegate:GetTransform()
end

return IBattleCardUIDelegate
