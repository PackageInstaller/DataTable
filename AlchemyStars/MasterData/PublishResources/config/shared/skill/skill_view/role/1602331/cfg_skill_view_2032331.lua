LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602331/cfg_skill_view_2032331.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A� �� �� �B� �@��AA �A � B  A�  � ��  �B� +A�K��� ��  A�  �B  � � AC +C� kA����A B A ��  �B   K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 160233102,audioType=1; PlayCasterBindEffect,effectID=160233105; �      �
      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4,sortParam=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160233106,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500; " PlayTargetAddBuff,buffID=20011; 5 PlaySkillAttackRange,showTime=200,isEffectRange=0; H PlaySummonTrap,trapID=2803501,effectID=160234105; Wait,waitTime=1000;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV