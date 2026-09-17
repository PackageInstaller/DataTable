local this = class("formationStore", G_BaseStore)
this.event = {
  formationTeamRefresh = "onFormationDataUpdate"
}
this:importPartialClass(require(L_R.store .. "formation.formationState"))
return this
