LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602181/cfg_skill_view_300218.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �� � AC +C� kA����A B A ��  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1602181,waitTime = 2000;��       PlayAudio,audioID = 160218104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=160218110; Wait,waitTime=500; PlayEffectAGridPos,effectID=160218108,gridPosX=5,gridPosY=4; Wait,waitTime=300; PlayCasterVisible,visible=0; PlayCameraEffect,effectID =160218106; Wait,waitTime=200; PlayEffectAtPickUpIndexGrid,effectID=160218107,pickUpIndex=1; Wait,waitTime=1800; PlayCasterVisible,visible=1; PlayEffectAtCasterPos, effectID=160218109; Wait,waitTime=1800; �
      � DataSelectScopeGridRangePickUp,pickUpIndex=1; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlaySummonTrap,trapID=2803501;� DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=4402183,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV