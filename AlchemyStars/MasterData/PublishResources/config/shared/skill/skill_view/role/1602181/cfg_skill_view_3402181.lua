LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602181/cfg_skill_view_3402181.lua         1     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1602181,waitTime = 2000;��       PlayAudio,audioID = 160218104,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=160218110; Wait,waitTime=500; PlayEffectAGridPos,effectID=160218108,gridPosX=5,gridPosY=4; Wait,waitTime=300; PlayCasterVisible,visible=0; PlayCameraEffect,effectID =160218106; Wait,waitTime=200; PlayEffectAtPickUpIndexGrid,effectID=160218107,pickUpIndex=1; Wait,waitTime=1800; PlayCasterVisible,visible=1; PlayEffectAtCasterPos, effectID=160218109; Wait,waitTime=1800; �
      � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000;         1                                                                                                                                                         key	   1   config,   1      _ENV