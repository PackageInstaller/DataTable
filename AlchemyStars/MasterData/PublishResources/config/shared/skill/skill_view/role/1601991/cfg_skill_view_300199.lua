LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1601991/cfg_skill_view_300199.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600891,waitTime = 2000; � PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160199108; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2634,audioType=1; Wait,waitTime=5000; �	      @ PlayEffectAtPickUpIndexGrid,effectID=160199109,pickUpIndex=1; �      ��       DataSelectScopeGridRange,effectType=6; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160199110,label=playRangeEffect; Wait,waitTime=100; PlayGridRangeConvert,dataSource=6; PlaySummonTrap,trapID=621; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        <                                                                                                                                                                                          key	   <   config7   <      _ENV