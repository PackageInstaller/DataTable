LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1605/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501421/cfg_skill_view_300142.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA����A B A ��  �B  � K� � kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501421,waitTime = 2000;�k       PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2390,audioType=1; PlayCasterBindEffect,effectID = 3330; PlayCasterLineToPickGridEff,lineOnCaster=Bip001 R Hand,lineOnEffect=lineb,lineEffectID=3332,lineEffectDelay=800,lineEffectDuration=866,gridEffectID=3333,pickUpIndex=1,dirOnPickup=1; Wait,waitTime=2200; :      �       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=0; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain;        � PlayCasterLineRenderer,lineEffectID=3332,lineTarget=lineb,lineCurrent=Bip001 R Hand; DataSelectScopeGridRange,effectType=1; PlayShowLineRenderer,show=1; Wait,waitTime=866; PlayShowLineRenderer,show=0;       ! PlayMultiTraction,moveSpeed=6;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV