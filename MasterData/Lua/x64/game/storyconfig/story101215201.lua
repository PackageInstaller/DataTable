return {
	Play121521001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121521001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play121521002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J12f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12f")
				var_4_0.name = "J12f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J12f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J12f

				arg_1_1.bgs_.J12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J12f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "1029ui_story"

			if arg_1_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1029ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1029ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1029ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1029ui_story == nil then
				arg_1_1.var_.characterEffect1029ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1029ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 1.8) / var_4_15)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1029ui_story then
				arg_1_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_4_16 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_17 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_17.name = var_4_16
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_16] = var_4_17

				local var_4_18 = var_4_17:GetComponentInChildren(typeof(CharacterEffect))

				var_4_18.enabled = true

				local var_4_19 = GameObjectTools.GetOrAddComponent(var_4_17, typeof(DynamicBoneHelper))

				if var_4_19 then
					var_4_19:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_18.transform, false)

				arg_1_1.var_[var_4_16 .. "Animator"] = var_4_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_20 = arg_1_1.actors_["1084ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_20.localPosition
			end

			local var_4_21 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_21 then
				var_4_20.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_1_1.time_ - 1.8) / var_4_21)
				var_4_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_20.position).x, (manager.ui.mainCamera.transform.position - var_4_20.position).y, (manager.ui.mainCamera.transform.position - var_4_20.position).z)
				var_4_20.localEulerAngles.z = 0
				var_4_20.localEulerAngles.x = 0
				var_4_20.localEulerAngles = var_4_20.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_21 and arg_1_1.time_ < 1.8 + var_4_21 + arg_4_0 then
				var_4_20.localPosition = Vector3.New(0.7, -0.97, -6)
				var_4_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_20.position).x, (manager.ui.mainCamera.transform.position - var_4_20.position).y, (manager.ui.mainCamera.transform.position - var_4_20.position).z)
				var_4_20.localEulerAngles.z = 0
				var_4_20.localEulerAngles.x = 0
				var_4_20.localEulerAngles = var_4_20.localEulerAngles
			end

			local var_4_22 = arg_1_1.actors_["1084ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_23 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_23 and not isNil(var_4_22) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_22) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 1.8) / var_4_23)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_23 and arg_1_1.time_ < 1.8 + var_4_23 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_29 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 0.725

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_33 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(121521001).content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 29 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_33) / 29)

				if (29 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_33) / 29)) > 0 and var_4_31 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_30 = var_4_30 + 0.3

					if var_4_35 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_30 + 0.3
			local var_4_37 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_30 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play121521002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121521002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play121521003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.625

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(121521002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 65 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 65)

				if (65 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 65)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play121521003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121521003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play121521004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(121521003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play121521004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121521004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121521005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(121521004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 28)

				if (28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 28)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play121521005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121521005
		arg_21_1.duration_ = 3.17

		local var_21_0 = {
			ja = 3.166,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play121521006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) and arg_21_1.var_.characterEffect1029ui_story == nil then
				arg_21_1.var_.characterEffect1029ui_story = arg_21_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) then
				if arg_21_1.var_.characterEffect1029ui_story and not isNil(arg_21_1.actors_["1029ui_story"]) then
					arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1029ui_story"]) and arg_21_1.var_.characterEffect1029ui_story then
				arg_21_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(121521005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 3 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 3)

				if (3 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 3)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521005", "story_v_out_121521.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521005", "story_v_out_121521.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_121521", "121521005", "story_v_out_121521.awb")

						arg_21_1:RecordAudio("121521005", var_24_9)
						arg_21_1:RecordAudio("121521005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121521", "121521005", "story_v_out_121521.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121521", "121521005", "story_v_out_121521.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play121521006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121521006
		arg_25_1.duration_ = 11.6

		local var_25_0 = {
			ja = 11.6,
			ko = 7.7,
			zh = 7.7
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play121521007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = arg_25_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(arg_25_1.actors_["1084ui_story"]) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_28_2 = arg_25_1.actors_["1029ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1029ui_story == nil then
				arg_25_1.var_.characterEffect1029ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1029ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1029ui_story then
				arg_25_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(121521006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 32 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 32)

				if (32 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 32)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521006", "story_v_out_121521.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521006", "story_v_out_121521.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_121521", "121521006", "story_v_out_121521.awb")

						arg_25_1:RecordAudio("121521006", var_28_11)
						arg_25_1:RecordAudio("121521006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121521", "121521006", "story_v_out_121521.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121521", "121521006", "story_v_out_121521.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121521007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121521007
		arg_29_1.duration_ = 10.93

		local var_29_0 = {
			ja = 10.933,
			ko = 6.333,
			zh = 6.333
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play121521008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) and arg_29_1.var_.characterEffect1029ui_story == nil then
				arg_29_1.var_.characterEffect1029ui_story = arg_29_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) then
				if arg_29_1.var_.characterEffect1029ui_story and not isNil(arg_29_1.actors_["1029ui_story"]) then
					arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1029ui_story"]) and arg_29_1.var_.characterEffect1029ui_story then
				arg_29_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = arg_29_1.actors_["1084ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_32_4 = 0
			local var_32_5 = 0.75

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(121521007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 30 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 30)

				if (30 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 30)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521007", "story_v_out_121521.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521007", "story_v_out_121521.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_121521", "121521007", "story_v_out_121521.awb")

						arg_29_1:RecordAudio("121521007", var_32_11)
						arg_29_1:RecordAudio("121521007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121521", "121521007", "story_v_out_121521.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121521", "121521007", "story_v_out_121521.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play121521008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121521008
		arg_33_1.duration_ = 11.43

		local var_33_0 = {
			ja = 11.433,
			ko = 7.5,
			zh = 7.5
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play121521009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_36_0 = 0
			local var_36_1 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(121521008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 31 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 31)

				if (31 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 31)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521008", "story_v_out_121521.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_121521", "121521008", "story_v_out_121521.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_121521", "121521008", "story_v_out_121521.awb")

						arg_33_1:RecordAudio("121521008", var_36_7)
						arg_33_1:RecordAudio("121521008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121521", "121521008", "story_v_out_121521.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121521", "121521008", "story_v_out_121521.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121521009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121521009
		arg_37_1.duration_ = 11.73

		local var_37_0 = {
			ja = 11.733,
			ko = 7.733,
			zh = 7.733
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play121521010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = arg_37_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(arg_37_1.actors_["1084ui_story"]) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1084ui_story"]) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_40_2 = arg_37_1.actors_["1029ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1029ui_story == nil then
				arg_37_1.var_.characterEffect1029ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1029ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1029ui_story then
				arg_37_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 0.9

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(121521009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 36 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 36)

				if (36 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 36)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521009", "story_v_out_121521.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521009", "story_v_out_121521.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_121521", "121521009", "story_v_out_121521.awb")

						arg_37_1:RecordAudio("121521009", var_40_11)
						arg_37_1:RecordAudio("121521009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121521", "121521009", "story_v_out_121521.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121521", "121521009", "story_v_out_121521.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play121521010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121521010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play121521011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = arg_41_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(arg_41_1.actors_["1084ui_story"]) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1084ui_story"]) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 1.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(121521010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 45 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 45)

				if (45 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 45)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121521011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121521011
		arg_45_1.duration_ = 4

		local var_45_0 = {
			ja = 1.999999999999,
			ko = 4,
			zh = 4
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play121521012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) and arg_45_1.var_.characterEffect1029ui_story == nil then
				arg_45_1.var_.characterEffect1029ui_story = arg_45_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) then
				if arg_45_1.var_.characterEffect1029ui_story and not isNil(arg_45_1.actors_["1029ui_story"]) then
					arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1029ui_story"]) and arg_45_1.var_.characterEffect1029ui_story then
				arg_45_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_2 = 0
			local var_48_3 = 0.375

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(121521011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 15 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 15)

				if (15 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 15)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521011", "story_v_out_121521.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521011", "story_v_out_121521.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_121521", "121521011", "story_v_out_121521.awb")

						arg_45_1:RecordAudio("121521011", var_48_9)
						arg_45_1:RecordAudio("121521011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121521", "121521011", "story_v_out_121521.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121521", "121521011", "story_v_out_121521.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_10 and arg_45_1.time_ < var_48_2 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121521012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121521012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play121521013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) and arg_49_1.var_.characterEffect1029ui_story == nil then
				arg_49_1.var_.characterEffect1029ui_story = arg_49_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) then
				if arg_49_1.var_.characterEffect1029ui_story and not isNil(arg_49_1.actors_["1029ui_story"]) then
					arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1029ui_story"]) and arg_49_1.var_.characterEffect1029ui_story then
				arg_49_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.9

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(121521012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)

				if (36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121521013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121521013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play121521014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(121521013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 42)

				if (42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 42)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121521014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121521014
		arg_57_1.duration_ = 10.6

		local var_57_0 = {
			ja = 10.6,
			ko = 7.2,
			zh = 7.2
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121521015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = arg_57_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(arg_57_1.actors_["1084ui_story"]) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_60_2 = 0
			local var_60_3 = 0.9

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(121521014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 36 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 36)

				if (36 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 36)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521014", "story_v_out_121521.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521014", "story_v_out_121521.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_121521", "121521014", "story_v_out_121521.awb")

						arg_57_1:RecordAudio("121521014", var_60_9)
						arg_57_1:RecordAudio("121521014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_121521", "121521014", "story_v_out_121521.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_121521", "121521014", "story_v_out_121521.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play121521015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121521015
		arg_61_1.duration_ = 5.5

		local var_61_0 = {
			ja = 5.5,
			ko = 4.966,
			zh = 4.966
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play121521016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.575

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(121521015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 23)

				if (23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 23)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521015", "story_v_out_121521.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521015", "story_v_out_121521.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_121521", "121521015", "story_v_out_121521.awb")

						arg_61_1:RecordAudio("121521015", var_64_6)
						arg_61_1:RecordAudio("121521015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121521", "121521015", "story_v_out_121521.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121521", "121521015", "story_v_out_121521.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play121521016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121521016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play121521017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) and arg_65_1.var_.characterEffect1029ui_story == nil then
				arg_65_1.var_.characterEffect1029ui_story = arg_65_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) then
				if arg_65_1.var_.characterEffect1029ui_story and not isNil(arg_65_1.actors_["1029ui_story"]) then
					arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1029ui_story"]) and arg_65_1.var_.characterEffect1029ui_story then
				arg_65_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_2 = arg_65_1.actors_["1084ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(121521016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 5 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 5)

				if (5 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 5)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521016", "story_v_out_121521.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521016", "story_v_out_121521.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_121521", "121521016", "story_v_out_121521.awb")

						arg_65_1:RecordAudio("121521016", var_68_11)
						arg_65_1:RecordAudio("121521016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121521", "121521016", "story_v_out_121521.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121521", "121521016", "story_v_out_121521.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play121521017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121521017
		arg_69_1.duration_ = 4.23

		local var_69_0 = {
			ja = 4.233,
			ko = 3.1,
			zh = 3.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121521018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = arg_69_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(arg_69_1.actors_["1084ui_story"]) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4127")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_2 = arg_69_1.actors_["1029ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1029ui_story == nil then
				arg_69_1.var_.characterEffect1029ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect1029ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect1029ui_story then
				arg_69_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_72_4 = 0
			local var_72_5 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(121521017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 8 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 8)

				if (8 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 8)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521017", "story_v_out_121521.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521017", "story_v_out_121521.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_121521", "121521017", "story_v_out_121521.awb")

						arg_69_1:RecordAudio("121521017", var_72_11)
						arg_69_1:RecordAudio("121521017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121521", "121521017", "story_v_out_121521.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121521", "121521017", "story_v_out_121521.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121521018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121521018
		arg_73_1.duration_ = 12.57

		local var_73_0 = {
			ja = 12.566,
			ko = 11.1,
			zh = 11.1
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play121521019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1029ui_story"]) and arg_73_1.var_.characterEffect1029ui_story == nil then
				arg_73_1.var_.characterEffect1029ui_story = arg_73_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1029ui_story"]) then
				if arg_73_1.var_.characterEffect1029ui_story and not isNil(arg_73_1.actors_["1029ui_story"]) then
					arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1029ui_story"]) and arg_73_1.var_.characterEffect1029ui_story then
				arg_73_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_76_2 = arg_73_1.actors_["1084ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 1.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(121521018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 42 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 42)

				if (42 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 42)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521018", "story_v_out_121521.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521018", "story_v_out_121521.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_121521", "121521018", "story_v_out_121521.awb")

						arg_73_1:RecordAudio("121521018", var_76_11)
						arg_73_1:RecordAudio("121521018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121521", "121521018", "story_v_out_121521.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121521", "121521018", "story_v_out_121521.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play121521019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121521019
		arg_77_1.duration_ = 11.2

		local var_77_0 = {
			ja = 6.933,
			ko = 11.2,
			zh = 11.2
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121521020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(121521019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 47 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 47)

				if (47 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 47)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521019", "story_v_out_121521.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521019", "story_v_out_121521.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_121521", "121521019", "story_v_out_121521.awb")

						arg_77_1:RecordAudio("121521019", var_80_6)
						arg_77_1:RecordAudio("121521019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121521", "121521019", "story_v_out_121521.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121521", "121521019", "story_v_out_121521.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play121521020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121521020
		arg_81_1.duration_ = 11.4

		local var_81_0 = {
			ja = 10.833,
			ko = 11.4,
			zh = 11.4
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play121521021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(121521020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 46)

				if (46 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 46)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521020", "story_v_out_121521.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521020", "story_v_out_121521.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_121521", "121521020", "story_v_out_121521.awb")

						arg_81_1:RecordAudio("121521020", var_84_6)
						arg_81_1:RecordAudio("121521020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121521", "121521020", "story_v_out_121521.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121521", "121521020", "story_v_out_121521.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121521021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121521021
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121521022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = arg_85_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(arg_85_1.actors_["1084ui_story"]) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_88_2 = arg_85_1.actors_["1029ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1029ui_story == nil then
				arg_85_1.var_.characterEffect1029ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1029ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1029ui_story then
				arg_85_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_88_4 = 0
			local var_88_5 = 0.175

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(121521021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)

				if (7 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 7)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521021", "story_v_out_121521.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521021", "story_v_out_121521.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_121521", "121521021", "story_v_out_121521.awb")

						arg_85_1:RecordAudio("121521021", var_88_11)
						arg_85_1:RecordAudio("121521021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121521", "121521021", "story_v_out_121521.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121521", "121521021", "story_v_out_121521.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121521022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121521022
		arg_89_1.duration_ = 12.4

		local var_89_0 = {
			ja = 12.4,
			ko = 5.266,
			zh = 5.266
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121521023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) and arg_89_1.var_.characterEffect1029ui_story == nil then
				arg_89_1.var_.characterEffect1029ui_story = arg_89_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) then
				if arg_89_1.var_.characterEffect1029ui_story and not isNil(arg_89_1.actors_["1029ui_story"]) then
					arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1029ui_story"]) and arg_89_1.var_.characterEffect1029ui_story then
				arg_89_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action424")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = arg_89_1.actors_["1084ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.775

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(121521022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 31 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 31)

				if (31 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 31)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521022", "story_v_out_121521.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521022", "story_v_out_121521.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_121521", "121521022", "story_v_out_121521.awb")

						arg_89_1:RecordAudio("121521022", var_92_11)
						arg_89_1:RecordAudio("121521022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121521", "121521022", "story_v_out_121521.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121521", "121521022", "story_v_out_121521.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121521023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121521023
		arg_93_1.duration_ = 14.07

		local var_93_0 = {
			ja = 14.066,
			ko = 10.766,
			zh = 10.766
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play121521024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.025

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(121521023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 41 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 41)

				if (41 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 41)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521023", "story_v_out_121521.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521023", "story_v_out_121521.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_121521", "121521023", "story_v_out_121521.awb")

						arg_93_1:RecordAudio("121521023", var_96_6)
						arg_93_1:RecordAudio("121521023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121521", "121521023", "story_v_out_121521.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121521", "121521023", "story_v_out_121521.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121521024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121521024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play121521025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) and arg_97_1.var_.characterEffect1029ui_story == nil then
				arg_97_1.var_.characterEffect1029ui_story = arg_97_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) then
				if arg_97_1.var_.characterEffect1029ui_story and not isNil(arg_97_1.actors_["1029ui_story"]) then
					arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1029ui_story"]) and arg_97_1.var_.characterEffect1029ui_story then
				arg_97_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(121521024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 30 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 30)

				if (30 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 30)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121521025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121521025
		arg_101_1.duration_ = 4.47

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121521026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.bgs_.STblack == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_104_0.name = "STblack"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.STblack = var_104_0
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.STblack

				arg_101_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "STblack" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_5 = 2

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_5 then
				local var_104_6 = Color.New(0, 0, 0)

				var_104_6.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_4) / var_104_5)
				arg_101_1.mask_.color = var_104_6
			end

			if arg_101_1.time_ >= var_104_4 + var_104_5 and arg_101_1.time_ < var_104_4 + var_104_5 + arg_104_0 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = 1
				arg_101_1.mask_.color = var_104_7
			end

			local var_104_8 = 2

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 then
				local var_104_10 = Color.New(0, 0, 0)

				var_104_10.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_8) / var_104_9)
				arg_101_1.mask_.color = var_104_10
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 then
				local var_104_11 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_11.a = 0
				arg_101_1.mask_.color = var_104_11
			end

			local var_104_12 = arg_101_1.actors_["1029ui_story"].transform

			if 1.96599999815226 < arg_101_1.time_ and arg_101_1.time_ <= 1.96599999815226 + arg_104_0 then
				arg_101_1.var_.moveOldPos1029ui_story = var_104_12.localPosition
			end

			local var_104_13 = 0.001

			if 1.96599999815226 <= arg_101_1.time_ and arg_101_1.time_ < 1.96599999815226 + var_104_13 then
				var_104_12.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 1.96599999815226) / var_104_13)
				var_104_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_12.position).x, (manager.ui.mainCamera.transform.position - var_104_12.position).y, (manager.ui.mainCamera.transform.position - var_104_12.position).z)
				var_104_12.localEulerAngles.z = 0
				var_104_12.localEulerAngles.x = 0
				var_104_12.localEulerAngles = var_104_12.localEulerAngles
			end

			if arg_101_1.time_ >= 1.96599999815226 + var_104_13 and arg_101_1.time_ < 1.96599999815226 + var_104_13 + arg_104_0 then
				var_104_12.localPosition = Vector3.New(0, 100, 0)
				var_104_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_12.position).x, (manager.ui.mainCamera.transform.position - var_104_12.position).y, (manager.ui.mainCamera.transform.position - var_104_12.position).z)
				var_104_12.localEulerAngles.z = 0
				var_104_12.localEulerAngles.x = 0
				var_104_12.localEulerAngles = var_104_12.localEulerAngles
			end

			local var_104_14 = arg_101_1.actors_["1029ui_story"]

			if 1.96599999815226 < arg_101_1.time_ and arg_101_1.time_ <= 1.96599999815226 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.characterEffect1029ui_story == nil then
				arg_101_1.var_.characterEffect1029ui_story = var_104_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_15 = 0.034000001847744

			if 1.96599999815226 <= arg_101_1.time_ and arg_101_1.time_ < 1.96599999815226 + var_104_15 and not isNil(var_104_14) then
				if arg_101_1.var_.characterEffect1029ui_story and not isNil(var_104_14) then
					arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 1.96599999815226) / var_104_15)
				end
			end

			if arg_101_1.time_ >= 1.96599999815226 + var_104_15 and arg_101_1.time_ < 1.96599999815226 + var_104_15 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.characterEffect1029ui_story then
				arg_101_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_104_16 = arg_101_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_101_1.time_ and arg_101_1.time_ <= 1.96599999815226 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_16.localPosition
			end

			local var_104_17 = 0.001

			if 1.96599999815226 <= arg_101_1.time_ and arg_101_1.time_ < 1.96599999815226 + var_104_17 then
				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 1.96599999815226) / var_104_17)
				var_104_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_16.position).x, (manager.ui.mainCamera.transform.position - var_104_16.position).y, (manager.ui.mainCamera.transform.position - var_104_16.position).z)
				var_104_16.localEulerAngles.z = 0
				var_104_16.localEulerAngles.x = 0
				var_104_16.localEulerAngles = var_104_16.localEulerAngles
			end

			if arg_101_1.time_ >= 1.96599999815226 + var_104_17 and arg_101_1.time_ < 1.96599999815226 + var_104_17 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, 100, 0)
				var_104_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_16.position).x, (manager.ui.mainCamera.transform.position - var_104_16.position).y, (manager.ui.mainCamera.transform.position - var_104_16.position).z)
				var_104_16.localEulerAngles.z = 0
				var_104_16.localEulerAngles.x = 0
				var_104_16.localEulerAngles = var_104_16.localEulerAngles
			end

			local var_104_18 = arg_101_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_101_1.time_ and arg_101_1.time_ <= 1.96599999815226 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_19 = 0.034000001847744

			if 1.96599999815226 <= arg_101_1.time_ and arg_101_1.time_ < 1.96599999815226 + var_104_19 and not isNil(var_104_18) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_18) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 1.96599999815226) / var_104_19)
				end
			end

			if arg_101_1.time_ >= 1.96599999815226 + var_104_19 and arg_101_1.time_ < 1.96599999815226 + var_104_19 + arg_104_0 and not isNil(var_104_18) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				arg_101_1.fswbg_:SetActive(true)
				arg_101_1.dialog_:SetActive(false)

				arg_101_1.fswtw_.percent = 0
				arg_101_1.fswt_.text = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(121521025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.fswt_)

				arg_101_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_101_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_101_1.fswtw_:SetDirty()

				arg_101_1.typewritterCharCountI18N = 0

				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_20 = 2.01666666666667

			if 2.01666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 then
				arg_101_1.var_.oldValueTypewriter = arg_101_1.fswtw_.percent

				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_21 = 21
			local var_104_22 = 1.4
			local var_104_23, var_104_24 = arg_101_1:GetPercentByPara(arg_101_1:FormatText(arg_101_1:GetWordFromCfg(121521025).content), 1)

			if var_104_20 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				local var_104_25 = var_104_21 <= 0 and var_104_22 or var_104_22 * ((var_104_24 - arg_101_1.typewritterCharCountI18N) / var_104_21)

				if (var_104_21 <= 0 and var_104_22 or var_104_22 * ((var_104_24 - arg_101_1.typewritterCharCountI18N) / var_104_21)) > 0 and var_104_22 < var_104_25 then
					arg_101_1.talkMaxDuration = var_104_25

					if var_104_25 + var_104_20 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_25 + var_104_20
					end
				end
			end

			local var_104_26 = math.max(1.4, arg_101_1.talkMaxDuration)

			if var_104_20 <= arg_101_1.time_ and arg_101_1.time_ < var_104_20 + var_104_26 then
				arg_101_1.fswtw_.percent = Mathf.Lerp(arg_101_1.var_.oldValueTypewriter, var_104_23, (arg_101_1.time_ - var_104_20) / var_104_26)
				arg_101_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_101_1.fswtw_:SetDirty()
			end

			if arg_101_1.time_ >= var_104_20 + var_104_26 and arg_101_1.time_ < var_104_20 + var_104_26 + arg_104_0 then
				arg_101_1.fswtw_.percent = var_104_23

				arg_101_1.fswtw_:SetDirty()
				arg_101_1:ShowNextGo(true)

				arg_101_1.typewritterCharCountI18N = var_104_24
			end

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= 2 + arg_104_0 then
				local var_104_27 = arg_101_1.fswbg_.transform:Find("textbox/adapt/content") or arg_101_1.fswbg_.transform:Find("textbox/content")
				local var_104_28 = arg_101_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_104_29 = var_104_27:GetComponent("RectTransform")

				var_104_27:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_104_29.offsetMin = Vector2.New(0, 0)
				var_104_29.offsetMax = Vector2.New(0, 0)
			end

			if 0.3 < arg_101_1.time_ and arg_101_1.time_ <= 0.3 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_recordopen", "")
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play121521026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121521026
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play121521027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.J12g == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J12g")
				var_108_0.name = "J12g"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.J12g = var_108_0
			end

			if 1.98333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 1.98333333333333 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.J12g

				arg_105_1.bgs_.J12g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "J12g" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_5 = 2

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_5 then
				local var_108_6 = Color.New(0, 0, 0)

				var_108_6.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_4) / var_108_5)
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.time_ >= var_108_4 + var_108_5 and arg_105_1.time_ < var_108_4 + var_108_5 + arg_108_0 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = 1
				arg_105_1.mask_.color = var_108_7
			end

			local var_108_8 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 then
				local var_108_10 = Color.New(0, 0, 0)

				var_108_10.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_8) / var_108_9)
				arg_105_1.mask_.color = var_108_10
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 then
				local var_108_11 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_11.a = 0
				arg_105_1.mask_.color = var_108_11
			end

			local var_108_12 = arg_105_1.actors_["1029ui_story"].transform

			if 3.8 < arg_105_1.time_ and arg_105_1.time_ <= 3.8 + arg_108_0 then
				arg_105_1.var_.moveOldPos1029ui_story = var_108_12.localPosition
			end

			local var_108_13 = 0.001

			if 3.8 <= arg_105_1.time_ and arg_105_1.time_ < 3.8 + var_108_13 then
				var_108_12.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_105_1.time_ - 3.8) / var_108_13)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			if arg_105_1.time_ >= 3.8 + var_108_13 and arg_105_1.time_ < 3.8 + var_108_13 + arg_108_0 then
				var_108_12.localPosition = Vector3.New(0, -1.09, -6.2)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			local var_108_14 = arg_105_1.actors_["1029ui_story"]

			if 3.8 < arg_105_1.time_ and arg_105_1.time_ <= 3.8 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.characterEffect1029ui_story == nil then
				arg_105_1.var_.characterEffect1029ui_story = var_108_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_15 = 0.200000002980232

			if 3.8 <= arg_105_1.time_ and arg_105_1.time_ < 3.8 + var_108_15 and not isNil(var_108_14) then
				if arg_105_1.var_.characterEffect1029ui_story and not isNil(var_108_14) then
					arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 3.8) / var_108_15)
				end
			end

			if arg_105_1.time_ >= 3.8 + var_108_15 and arg_105_1.time_ < 3.8 + var_108_15 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.characterEffect1029ui_story then
				arg_105_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 1.98333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 1.98333333333333 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(false)
				arg_105_1.dialog_:SetActive(false)
				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_16 = 4
			local var_108_17 = 0.5

			if 4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_18 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_18:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_19 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(121521026).content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 20 <= 0 and var_108_17 or var_108_17 * (utf8.len(var_108_19) / 20)

				if (20 <= 0 and var_108_17 or var_108_17 * (utf8.len(var_108_19) / 20)) > 0 and var_108_17 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21
					var_108_16 = var_108_16 + 0.3

					if var_108_21 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = var_108_16 + 0.3
			local var_108_23 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_23 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_23

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_23 and arg_105_1.time_ < var_108_22 + var_108_23 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play121521027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 121521027
		arg_111_1.duration_ = 6.87

		local var_111_0 = {
			ja = 5.433,
			ko = 6.866,
			zh = 6.866
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play121521028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1029ui_story"]) and arg_111_1.var_.characterEffect1029ui_story == nil then
				arg_111_1.var_.characterEffect1029ui_story = arg_111_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1029ui_story"]) then
				if arg_111_1.var_.characterEffect1029ui_story and not isNil(arg_111_1.actors_["1029ui_story"]) then
					arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1029ui_story"]) and arg_111_1.var_.characterEffect1029ui_story then
				arg_111_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_114_2 = 0
			local var_114_3 = 0.35

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(121521027)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 14 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 14)

				if (14 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 14)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521027", "story_v_out_121521.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521027", "story_v_out_121521.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_121521", "121521027", "story_v_out_121521.awb")

						arg_111_1:RecordAudio("121521027", var_114_9)
						arg_111_1:RecordAudio("121521027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_121521", "121521027", "story_v_out_121521.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_121521", "121521027", "story_v_out_121521.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play121521028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 121521028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play121521029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1029ui_story"]) and arg_115_1.var_.characterEffect1029ui_story == nil then
				arg_115_1.var_.characterEffect1029ui_story = arg_115_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1029ui_story"]) then
				if arg_115_1.var_.characterEffect1029ui_story and not isNil(arg_115_1.actors_["1029ui_story"]) then
					arg_115_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1029ui_story"]) and arg_115_1.var_.characterEffect1029ui_story then
				arg_115_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.175

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(121521028).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 7 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 7)

				if (7 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 7)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play121521029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 121521029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play121521030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.9

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(121521029).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 36 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 36)

				if (36 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 36)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play121521030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 121521030
		arg_123_1.duration_ = 10.23

		local var_123_0 = {
			ja = 10.233,
			ko = 5.766,
			zh = 5.766
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play121521031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1029ui_story"]) and arg_123_1.var_.characterEffect1029ui_story == nil then
				arg_123_1.var_.characterEffect1029ui_story = arg_123_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1029ui_story"]) then
				if arg_123_1.var_.characterEffect1029ui_story and not isNil(arg_123_1.actors_["1029ui_story"]) then
					arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1029ui_story"]) and arg_123_1.var_.characterEffect1029ui_story then
				arg_123_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action442")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_2 = 0
			local var_126_3 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(121521030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 26 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 26)

				if (26 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 26)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521030", "story_v_out_121521.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521030", "story_v_out_121521.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_121521", "121521030", "story_v_out_121521.awb")

						arg_123_1:RecordAudio("121521030", var_126_9)
						arg_123_1:RecordAudio("121521030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_121521", "121521030", "story_v_out_121521.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_121521", "121521030", "story_v_out_121521.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play121521031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 121521031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play121521032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1029ui_story"]) and arg_127_1.var_.characterEffect1029ui_story == nil then
				arg_127_1.var_.characterEffect1029ui_story = arg_127_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1029ui_story"]) then
				if arg_127_1.var_.characterEffect1029ui_story and not isNil(arg_127_1.actors_["1029ui_story"]) then
					arg_127_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1029ui_story"]) and arg_127_1.var_.characterEffect1029ui_story then
				arg_127_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.55

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(121521031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 22 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 22)

				if (22 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 22)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play121521032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 121521032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play121521033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1029ui_story = arg_131_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).z)
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles = arg_131_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1029ui_story"].transform.position).z)
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1029ui_story"].transform.localEulerAngles = arg_131_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1029ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1029ui_story == nil then
				arg_131_1.var_.characterEffect1029ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1029ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_2)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1029ui_story then
				arg_131_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_134_3 = 0
			local var_134_4 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(121521032).content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 40 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 40)

				if (40 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 40)) > 0 and var_134_4 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_3
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_4, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_3) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_8 and arg_131_1.time_ < var_134_3 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play121521033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 121521033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play121521034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.75

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(121521033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 30)

				if (30 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 30)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play121521034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 121521034
		arg_139_1.duration_ = 6.5

		local var_139_0 = {
			ja = 6.5,
			ko = 3.6,
			zh = 3.6
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play121521035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "1075ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1075ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["1075ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["1075ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["1075ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1075ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1075ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1075ui_story == nil then
				arg_139_1.var_.characterEffect1075ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1075ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1075ui_story then
				arg_139_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_142_8 = arg_139_1.actors_["1084ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_8.localPosition
			end

			local var_142_9 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 then
				var_142_8.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_139_1.time_ - 0) / var_142_9)
				var_142_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_8.position).x, (manager.ui.mainCamera.transform.position - var_142_8.position).y, (manager.ui.mainCamera.transform.position - var_142_8.position).z)
				var_142_8.localEulerAngles.z = 0
				var_142_8.localEulerAngles.x = 0
				var_142_8.localEulerAngles = var_142_8.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 then
				var_142_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_142_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_8.position).x, (manager.ui.mainCamera.transform.position - var_142_8.position).y, (manager.ui.mainCamera.transform.position - var_142_8.position).z)
				var_142_8.localEulerAngles.z = 0
				var_142_8.localEulerAngles.x = 0
				var_142_8.localEulerAngles = var_142_8.localEulerAngles
			end

			local var_142_10 = arg_139_1.actors_["1084ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_11 and not isNil(var_142_10) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_10) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_11)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_11 and arg_139_1.time_ < 0 + var_142_11 + arg_142_0 and not isNil(var_142_10) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_142_12 = 0
			local var_142_13 = 0.35

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(121521034)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 14 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 14)

				if (14 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 14)) > 0 and var_142_13 < var_142_17 then
					arg_139_1.talkMaxDuration = var_142_17

					if var_142_17 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521034", "story_v_out_121521.awb") ~= 0 then
					local var_142_18 = manager.audio:GetVoiceLength("story_v_out_121521", "121521034", "story_v_out_121521.awb") / 1000

					if var_142_18 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_12
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_121521", "121521034", "story_v_out_121521.awb")

						arg_139_1:RecordAudio("121521034", var_142_19)
						arg_139_1:RecordAudio("121521034", var_142_19)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_121521", "121521034", "story_v_out_121521.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_121521", "121521034", "story_v_out_121521.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_20 and arg_139_1.time_ < var_142_12 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play121521035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 121521035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play121521036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1075ui_story"]) and arg_143_1.var_.characterEffect1075ui_story == nil then
				arg_143_1.var_.characterEffect1075ui_story = arg_143_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1075ui_story"]) then
				if arg_143_1.var_.characterEffect1075ui_story and not isNil(arg_143_1.actors_["1075ui_story"]) then
					arg_143_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1075ui_story"]) and arg_143_1.var_.characterEffect1075ui_story then
				arg_143_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.575

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(121521035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 23 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 23)

				if (23 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 23)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play121521036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 121521036
		arg_147_1.duration_ = 8.33

		local var_147_0 = {
			ja = 8.333,
			ko = 7.933,
			zh = 7.933
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play121521037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1075ui_story"]) and arg_147_1.var_.characterEffect1075ui_story == nil then
				arg_147_1.var_.characterEffect1075ui_story = arg_147_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1075ui_story"]) then
				if arg_147_1.var_.characterEffect1075ui_story and not isNil(arg_147_1.actors_["1075ui_story"]) then
					arg_147_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1075ui_story"]) and arg_147_1.var_.characterEffect1075ui_story then
				arg_147_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_2 = 0
			local var_150_3 = 1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(121521036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 40 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 40)

				if (40 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 40)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521036", "story_v_out_121521.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521036", "story_v_out_121521.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_121521", "121521036", "story_v_out_121521.awb")

						arg_147_1:RecordAudio("121521036", var_150_9)
						arg_147_1:RecordAudio("121521036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_121521", "121521036", "story_v_out_121521.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_121521", "121521036", "story_v_out_121521.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play121521037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 121521037
		arg_151_1.duration_ = 4.63

		local var_151_0 = {
			ja = 4.633,
			ko = 3.033,
			zh = 3.033
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play121521038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = arg_151_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(arg_151_1.actors_["1084ui_story"]) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_2 = arg_151_1.actors_["1075ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1075ui_story == nil then
				arg_151_1.var_.characterEffect1075ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_3 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.characterEffect1075ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1075ui_story then
				arg_151_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_154_4 = 0
			local var_154_5 = 0.375

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(121521037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 15 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 15)

				if (15 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 15)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521037", "story_v_out_121521.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521037", "story_v_out_121521.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_121521", "121521037", "story_v_out_121521.awb")

						arg_151_1:RecordAudio("121521037", var_154_11)
						arg_151_1:RecordAudio("121521037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_121521", "121521037", "story_v_out_121521.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_121521", "121521037", "story_v_out_121521.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play121521038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 121521038
		arg_155_1.duration_ = 6.67

		local var_155_0 = {
			ja = 5.6,
			ko = 6.666,
			zh = 6.666
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play121521039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1075ui_story"]) and arg_155_1.var_.characterEffect1075ui_story == nil then
				arg_155_1.var_.characterEffect1075ui_story = arg_155_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1075ui_story"]) then
				if arg_155_1.var_.characterEffect1075ui_story and not isNil(arg_155_1.actors_["1075ui_story"]) then
					arg_155_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1075ui_story"]) and arg_155_1.var_.characterEffect1075ui_story then
				arg_155_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_2 = arg_155_1.actors_["1084ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1084ui_story == nil then
				arg_155_1.var_.characterEffect1084ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.characterEffect1084ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_3)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1084ui_story then
				arg_155_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_158_4 = 0
			local var_158_5 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(121521038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 35 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 35)

				if (35 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 35)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521038", "story_v_out_121521.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521038", "story_v_out_121521.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_121521", "121521038", "story_v_out_121521.awb")

						arg_155_1:RecordAudio("121521038", var_158_11)
						arg_155_1:RecordAudio("121521038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_121521", "121521038", "story_v_out_121521.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_121521", "121521038", "story_v_out_121521.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play121521039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 121521039
		arg_159_1.duration_ = 7.4

		local var_159_0 = {
			ja = 7.4,
			ko = 6.233,
			zh = 6.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play121521040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.775

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(121521039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 31 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 31)

				if (31 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 31)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521039", "story_v_out_121521.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521039", "story_v_out_121521.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_121521", "121521039", "story_v_out_121521.awb")

						arg_159_1:RecordAudio("121521039", var_162_6)
						arg_159_1:RecordAudio("121521039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_121521", "121521039", "story_v_out_121521.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_121521", "121521039", "story_v_out_121521.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play121521040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 121521040
		arg_163_1.duration_ = 10.97

		local var_163_0 = {
			ja = 10.966,
			ko = 9.166,
			zh = 9.166
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play121521041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1075ui_story"]) and arg_163_1.var_.characterEffect1075ui_story == nil then
				arg_163_1.var_.characterEffect1075ui_story = arg_163_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1075ui_story"]) then
				if arg_163_1.var_.characterEffect1075ui_story and not isNil(arg_163_1.actors_["1075ui_story"]) then
					arg_163_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1075ui_story"]) and arg_163_1.var_.characterEffect1075ui_story then
				arg_163_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_166_2 = 0
			local var_166_3 = 1.175

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(121521040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 47 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 47)

				if (47 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 47)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521040", "story_v_out_121521.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521040", "story_v_out_121521.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_121521", "121521040", "story_v_out_121521.awb")

						arg_163_1:RecordAudio("121521040", var_166_9)
						arg_163_1:RecordAudio("121521040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_121521", "121521040", "story_v_out_121521.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_121521", "121521040", "story_v_out_121521.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play121521041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 121521041
		arg_167_1.duration_ = 12.1

		local var_167_0 = {
			ja = 12.1,
			ko = 7.4,
			zh = 7.4
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play121521042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1084ui_story"]) and arg_167_1.var_.characterEffect1084ui_story == nil then
				arg_167_1.var_.characterEffect1084ui_story = arg_167_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1084ui_story"]) then
				if arg_167_1.var_.characterEffect1084ui_story and not isNil(arg_167_1.actors_["1084ui_story"]) then
					arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1084ui_story"]) and arg_167_1.var_.characterEffect1084ui_story then
				arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_170_2 = arg_167_1.actors_["1075ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1075ui_story == nil then
				arg_167_1.var_.characterEffect1075ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_3 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.characterEffect1075ui_story and not isNil(var_170_2) then
					arg_167_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1075ui_story then
				arg_167_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_170_4 = 0
			local var_170_5 = 0.825

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(121521041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 34 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 34)

				if (34 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 34)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521041", "story_v_out_121521.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521041", "story_v_out_121521.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_121521", "121521041", "story_v_out_121521.awb")

						arg_167_1:RecordAudio("121521041", var_170_11)
						arg_167_1:RecordAudio("121521041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_121521", "121521041", "story_v_out_121521.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_121521", "121521041", "story_v_out_121521.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play121521042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 121521042
		arg_171_1.duration_ = 10.57

		local var_171_0 = {
			ja = 10.566,
			ko = 6.633,
			zh = 6.633
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play121521043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1075ui_story"]) and arg_171_1.var_.characterEffect1075ui_story == nil then
				arg_171_1.var_.characterEffect1075ui_story = arg_171_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1075ui_story"]) then
				if arg_171_1.var_.characterEffect1075ui_story and not isNil(arg_171_1.actors_["1075ui_story"]) then
					arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1075ui_story"]) and arg_171_1.var_.characterEffect1075ui_story then
				arg_171_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_174_2 = arg_171_1.actors_["1084ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_3)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_174_4 = 0
			local var_174_5 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(121521042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 25 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 25)

				if (25 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 25)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521042", "story_v_out_121521.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521042", "story_v_out_121521.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_121521", "121521042", "story_v_out_121521.awb")

						arg_171_1:RecordAudio("121521042", var_174_11)
						arg_171_1:RecordAudio("121521042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_121521", "121521042", "story_v_out_121521.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_121521", "121521042", "story_v_out_121521.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play121521043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 121521043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play121521044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1075ui_story"]) and arg_175_1.var_.characterEffect1075ui_story == nil then
				arg_175_1.var_.characterEffect1075ui_story = arg_175_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1075ui_story"]) then
				if arg_175_1.var_.characterEffect1075ui_story and not isNil(arg_175_1.actors_["1075ui_story"]) then
					arg_175_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1075ui_story"]) and arg_175_1.var_.characterEffect1075ui_story then
				arg_175_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(121521043).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 4 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 4)

				if (4 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 4)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play121521044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 121521044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play121521045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.95

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(121521044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 38 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 38)

				if (38 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 38)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play121521045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 121521045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play121521046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.4

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(121521045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 56 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 56)

				if (56 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 56)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play121521046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 121521046
		arg_187_1.duration_ = 8.8

		local var_187_0 = {
			ja = 8.8,
			ko = 6.166,
			zh = 6.166
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play121521047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) and arg_187_1.var_.characterEffect1084ui_story == nil then
				arg_187_1.var_.characterEffect1084ui_story = arg_187_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) then
				if arg_187_1.var_.characterEffect1084ui_story and not isNil(arg_187_1.actors_["1084ui_story"]) then
					arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1084ui_story"]) and arg_187_1.var_.characterEffect1084ui_story then
				arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_190_2 = 0
			local var_190_3 = 0.825

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(121521046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 33 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 33)

				if (33 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 33)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521046", "story_v_out_121521.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521046", "story_v_out_121521.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_121521", "121521046", "story_v_out_121521.awb")

						arg_187_1:RecordAudio("121521046", var_190_9)
						arg_187_1:RecordAudio("121521046", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_121521", "121521046", "story_v_out_121521.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_121521", "121521046", "story_v_out_121521.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play121521047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 121521047
		arg_191_1.duration_ = 9.53

		local var_191_0 = {
			ja = 9.533,
			ko = 8,
			zh = 8
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play121521048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1075ui_story"]) and arg_191_1.var_.characterEffect1075ui_story == nil then
				arg_191_1.var_.characterEffect1075ui_story = arg_191_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1075ui_story"]) then
				if arg_191_1.var_.characterEffect1075ui_story and not isNil(arg_191_1.actors_["1075ui_story"]) then
					arg_191_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1075ui_story"]) and arg_191_1.var_.characterEffect1075ui_story then
				arg_191_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_2 = arg_191_1.actors_["1084ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_3 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_2) then
					arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_3)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.characterEffect1084ui_story then
				arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_194_4 = 0
			local var_194_5 = 1.05

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(121521047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 42 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 42)

				if (42 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 42)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521047", "story_v_out_121521.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521047", "story_v_out_121521.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_121521", "121521047", "story_v_out_121521.awb")

						arg_191_1:RecordAudio("121521047", var_194_11)
						arg_191_1:RecordAudio("121521047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_121521", "121521047", "story_v_out_121521.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_121521", "121521047", "story_v_out_121521.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play121521048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 121521048
		arg_195_1.duration_ = 11.4

		local var_195_0 = {
			ja = 11.4,
			ko = 6.733,
			zh = 6.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play121521049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(121521048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 34 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 34)

				if (34 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 34)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521048", "story_v_out_121521.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521048", "story_v_out_121521.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_121521", "121521048", "story_v_out_121521.awb")

						arg_195_1:RecordAudio("121521048", var_198_6)
						arg_195_1:RecordAudio("121521048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_121521", "121521048", "story_v_out_121521.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_121521", "121521048", "story_v_out_121521.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play121521049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 121521049
		arg_199_1.duration_ = 6.63

		local var_199_0 = {
			ja = 6.633,
			ko = 3.5,
			zh = 3.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play121521050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = arg_199_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) then
				if arg_199_1.var_.characterEffect1084ui_story and not isNil(arg_199_1.actors_["1084ui_story"]) then
					arg_199_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1084ui_story"]) and arg_199_1.var_.characterEffect1084ui_story then
				arg_199_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_2 = arg_199_1.actors_["1075ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1075ui_story == nil then
				arg_199_1.var_.characterEffect1075ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1075ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1075ui_story then
				arg_199_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_202_4 = 0
			local var_202_5 = 0.4

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(121521049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 16 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 16)

				if (16 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 16)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521049", "story_v_out_121521.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521049", "story_v_out_121521.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_121521", "121521049", "story_v_out_121521.awb")

						arg_199_1:RecordAudio("121521049", var_202_11)
						arg_199_1:RecordAudio("121521049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_121521", "121521049", "story_v_out_121521.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_121521", "121521049", "story_v_out_121521.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play121521050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 121521050
		arg_203_1.duration_ = 8.03

		local var_203_0 = {
			ja = 5.133,
			ko = 8.033,
			zh = 8.033
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play121521051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1075ui_story"]) and arg_203_1.var_.characterEffect1075ui_story == nil then
				arg_203_1.var_.characterEffect1075ui_story = arg_203_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1075ui_story"]) then
				if arg_203_1.var_.characterEffect1075ui_story and not isNil(arg_203_1.actors_["1075ui_story"]) then
					arg_203_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1075ui_story"]) and arg_203_1.var_.characterEffect1075ui_story then
				arg_203_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_206_2 = arg_203_1.actors_["1084ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_3 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_2) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_3)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_206_4 = 0
			local var_206_5 = 1.025

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(121521050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 41 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 41)

				if (41 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 41)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521050", "story_v_out_121521.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521050", "story_v_out_121521.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_121521", "121521050", "story_v_out_121521.awb")

						arg_203_1:RecordAudio("121521050", var_206_11)
						arg_203_1:RecordAudio("121521050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_121521", "121521050", "story_v_out_121521.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_121521", "121521050", "story_v_out_121521.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play121521051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 121521051
		arg_207_1.duration_ = 4.93

		local var_207_0 = {
			ja = 4.933,
			ko = 4.433,
			zh = 4.433
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play121521052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.5

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(121521051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 20 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 20)

				if (20 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 20)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521051", "story_v_out_121521.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521051", "story_v_out_121521.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_121521", "121521051", "story_v_out_121521.awb")

						arg_207_1:RecordAudio("121521051", var_210_6)
						arg_207_1:RecordAudio("121521051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_121521", "121521051", "story_v_out_121521.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_121521", "121521051", "story_v_out_121521.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play121521052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 121521052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play121521053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1075ui_story = arg_211_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).z)
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles = arg_211_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1075ui_story"].transform.position).z)
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1075ui_story"].transform.localEulerAngles = arg_211_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1075ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1075ui_story == nil then
				arg_211_1.var_.characterEffect1075ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1075ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1075ui_story then
				arg_211_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_214_3 = arg_211_1.actors_["1084ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1084ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0, 100, 0)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["1084ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_5) then
					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_6)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1084ui_story then
				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_214_7 = 0
			local var_214_8 = 1.325

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(121521052).content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 53 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 53)

				if (53 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 53)) > 0 and var_214_8 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_7 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_7
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_8, arg_211_1.talkMaxDuration)

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_7) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_7 + var_214_12 and arg_211_1.time_ < var_214_7 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play121521053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 121521053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play121521054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(121521053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 47 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 47)

				if (47 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 47)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play121521054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 121521054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play121521055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.275

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(121521054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 11 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 11)

				if (11 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 11)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play121521055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 121521055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play121521056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.8

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(121521055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 32 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 32)

				if (32 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 32)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play121521056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 121521056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play121521057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_engineclose", "")
			end

			local var_230_1 = 0
			local var_230_2 = 0.775

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(121521056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 31 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 31)

				if (31 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 31)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play121521057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 121521057
		arg_231_1.duration_ = 2.23

		local var_231_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play121521058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = arg_231_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).z)
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles = arg_231_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_231_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1084ui_story"].transform.position).z)
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1084ui_story"].transform.localEulerAngles = arg_231_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1084ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_234_4 = 0
			local var_234_5 = 0.2

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(121521057)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 8 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 8)

				if (8 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 8)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521057", "story_v_out_121521.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521057", "story_v_out_121521.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_121521", "121521057", "story_v_out_121521.awb")

						arg_231_1:RecordAudio("121521057", var_234_11)
						arg_231_1:RecordAudio("121521057", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_121521", "121521057", "story_v_out_121521.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_121521", "121521057", "story_v_out_121521.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play121521058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 121521058
		arg_235_1.duration_ = 9

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play121521059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if arg_235_1.bgs_.XH0306 == nil then
				local var_238_0 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0306")
				var_238_0.name = "XH0306"
				var_238_0.transform.parent = arg_235_1.stage_.transform
				var_238_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_.XH0306 = var_238_0
			end

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= 2 + arg_238_0 then
				local var_238_1 = arg_235_1.bgs_.XH0306

				arg_235_1.bgs_.XH0306.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_2 = var_238_1:GetComponent("SpriteRenderer")

				if var_238_2 and var_238_2.sprite then
					local var_238_3 = 2 * (var_238_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_1.transform.localScale = Vector3.New(var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, var_238_3 / var_238_2.sprite.bounds.size.y < var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x and var_238_3 * manager.ui.mainCameraCom_.aspect / var_238_2.sprite.bounds.size.x or var_238_3 / var_238_2.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "XH0306" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_4 = 0

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_5 = 2

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_5 then
				local var_238_6 = Color.New(0, 0, 0)

				var_238_6.a = Mathf.Lerp(0, 1, (arg_235_1.time_ - var_238_4) / var_238_5)
				arg_235_1.mask_.color = var_238_6
			end

			if arg_235_1.time_ >= var_238_4 + var_238_5 and arg_235_1.time_ < var_238_4 + var_238_5 + arg_238_0 then
				local var_238_7 = Color.New(0, 0, 0)

				var_238_7.a = 1
				arg_235_1.mask_.color = var_238_7
			end

			local var_238_8 = 2

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_9 = 2

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_9 then
				local var_238_10 = Color.New(0, 0, 0)

				var_238_10.a = Mathf.Lerp(1, 0, (arg_235_1.time_ - var_238_8) / var_238_9)
				arg_235_1.mask_.color = var_238_10
			end

			if arg_235_1.time_ >= var_238_8 + var_238_9 and arg_235_1.time_ < var_238_8 + var_238_9 + arg_238_0 then
				local var_238_11 = Color.New(0, 0, 0)

				arg_235_1.mask_.enabled = false
				var_238_11.a = 0
				arg_235_1.mask_.color = var_238_11
			end

			local var_238_12 = arg_235_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_235_1.time_ and arg_235_1.time_ <= 1.96599999815226 + arg_238_0 then
				arg_235_1.var_.moveOldPos1084ui_story = var_238_12.localPosition
			end

			local var_238_13 = 0.001

			if 1.96599999815226 <= arg_235_1.time_ and arg_235_1.time_ < 1.96599999815226 + var_238_13 then
				var_238_12.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 1.96599999815226) / var_238_13)
				var_238_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_12.position).x, (manager.ui.mainCamera.transform.position - var_238_12.position).y, (manager.ui.mainCamera.transform.position - var_238_12.position).z)
				var_238_12.localEulerAngles.z = 0
				var_238_12.localEulerAngles.x = 0
				var_238_12.localEulerAngles = var_238_12.localEulerAngles
			end

			if arg_235_1.time_ >= 1.96599999815226 + var_238_13 and arg_235_1.time_ < 1.96599999815226 + var_238_13 + arg_238_0 then
				var_238_12.localPosition = Vector3.New(0, 100, 0)
				var_238_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_12.position).x, (manager.ui.mainCamera.transform.position - var_238_12.position).y, (manager.ui.mainCamera.transform.position - var_238_12.position).z)
				var_238_12.localEulerAngles.z = 0
				var_238_12.localEulerAngles.x = 0
				var_238_12.localEulerAngles = var_238_12.localEulerAngles
			end

			local var_238_14 = arg_235_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_235_1.time_ and arg_235_1.time_ <= 1.96599999815226 + arg_238_0 and not isNil(var_238_14) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_15 = 0.034000001847744

			if 1.96599999815226 <= arg_235_1.time_ and arg_235_1.time_ < 1.96599999815226 + var_238_15 and not isNil(var_238_14) then
				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_14) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 1.96599999815226) / var_238_15)
				end
			end

			if arg_235_1.time_ >= 1.96599999815226 + var_238_15 and arg_235_1.time_ < 1.96599999815226 + var_238_15 + arg_238_0 and not isNil(var_238_14) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_238_16 = arg_235_1.bgs_.XH0306.transform

			if 2 < arg_235_1.time_ and arg_235_1.time_ <= 2 + arg_238_0 then
				arg_235_1.var_.moveOldPosXH0306 = var_238_16.localPosition
			end

			local var_238_17 = 0.001

			if 2 <= arg_235_1.time_ and arg_235_1.time_ < 2 + var_238_17 then
				var_238_16.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosXH0306, Vector3.New(0, 1, 9), (arg_235_1.time_ - 2) / var_238_17)
			end

			if arg_235_1.time_ >= 2 + var_238_17 and arg_235_1.time_ < 2 + var_238_17 + arg_238_0 then
				var_238_16.localPosition = Vector3.New(0, 1, 9)
			end

			local var_238_18 = arg_235_1.bgs_.XH0306.transform

			if 2.01666666666667 < arg_235_1.time_ and arg_235_1.time_ <= 2.01666666666667 + arg_238_0 then
				arg_235_1.var_.moveOldPosXH0306 = var_238_18.localPosition
			end

			local var_238_19 = 5

			if 2.01666666666667 <= arg_235_1.time_ and arg_235_1.time_ < 2.01666666666667 + var_238_19 then
				var_238_18.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPosXH0306, Vector3.New(0, 1, 10), (arg_235_1.time_ - 2.01666666666667) / var_238_19)
			end

			if arg_235_1.time_ >= 2.01666666666667 + var_238_19 and arg_235_1.time_ < 2.01666666666667 + var_238_19 + arg_238_0 then
				var_238_18.localPosition = Vector3.New(0, 1, 10)
			end

			local var_238_20 = 4

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_20 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			if arg_235_1.time_ >= var_238_20 + 3.01666666666667 and arg_235_1.time_ < var_238_20 + 3.01666666666667 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_21 = 4
			local var_238_22 = 0.45

			if 4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_23 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_23:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(121521058).content)

				arg_235_1.text_.text = var_238_24

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 18 <= 0 and var_238_22 or var_238_22 * (utf8.len(var_238_24) / 18)

				if (18 <= 0 and var_238_22 or var_238_22 * (utf8.len(var_238_24) / 18)) > 0 and var_238_22 < var_238_26 then
					arg_235_1.talkMaxDuration = var_238_26
					var_238_21 = var_238_21 + 0.3

					if var_238_26 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_26 + var_238_21
					end
				end

				arg_235_1.text_.text = var_238_24
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_27 = var_238_21 + 0.3
			local var_238_28 = math.max(var_238_22, arg_235_1.talkMaxDuration)

			if var_238_21 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_27 + var_238_28 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_27) / var_238_28

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_27 + var_238_28 and arg_235_1.time_ < var_238_27 + var_238_28 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0306",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play121521059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 121521059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play121521060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(121521059).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 32 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 32)

				if (32 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 32)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play121521060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 121521060
		arg_245_1.duration_ = 5.2

		local var_245_0 = {
			ja = 5.2,
			ko = 3.533,
			zh = 3.533
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play121521061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.25

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(121521060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 10 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 10)

				if (10 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 10)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521060", "story_v_out_121521.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521060", "story_v_out_121521.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_121521", "121521060", "story_v_out_121521.awb")

						arg_245_1:RecordAudio("121521060", var_248_6)
						arg_245_1:RecordAudio("121521060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_121521", "121521060", "story_v_out_121521.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_121521", "121521060", "story_v_out_121521.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play121521061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 121521061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play121521062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_engineclose_loop", "")
			end

			local var_252_1 = 0
			local var_252_2 = 1.55

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(121521061).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 62 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 62)

				if (62 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 62)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play121521062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 121521062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play121521063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.425

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(121521062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 57 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 57)

				if (57 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 57)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play121521063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 121521063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play121521064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.475

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(121521063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 19 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 19)

				if (19 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 19)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play121521064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 121521064
		arg_261_1.duration_ = 4.97

		local var_261_0 = {
			ja = 4.933,
			ko = 4.966,
			zh = 4.966
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play121521065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(121521064)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 29)

				if (29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 29)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521064", "story_v_out_121521.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521064", "story_v_out_121521.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_121521", "121521064", "story_v_out_121521.awb")

						arg_261_1:RecordAudio("121521064", var_264_6)
						arg_261_1:RecordAudio("121521064", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_121521", "121521064", "story_v_out_121521.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_121521", "121521064", "story_v_out_121521.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play121521065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 121521065
		arg_265_1.duration_ = 2.1

		local var_265_0 = {
			ja = 2.1,
			ko = 1.633,
			zh = 1.633
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play121521066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("stop", "music", "se_story_121_04", "se_story_121_04_engineclose_loop", "")

				local var_268_2 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_engineclose_loop")

				if "" ~= "" then
					if arg_265_1.bgmTxt_.text ~= var_268_2 and arg_265_1.bgmTxt_.text ~= "" then
						if arg_265_1.bgmTxt2_.text ~= "" then
							arg_265_1.bgmTxt_.text = arg_265_1.bgmTxt2_.text
						end

						arg_265_1.bgmTxt2_.text = var_268_2

						arg_265_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_265_1.bgmTxt_.text = var_268_2
						arg_265_1.bgmTxt2_.text = var_268_2
					end

					if arg_265_1.bgmTimer then
						arg_265_1.bgmTimer:Stop()

						arg_265_1.bgmTimer = nil
					end

					if arg_265_1.settingData.show_music_name == 1 then
						arg_265_1.musicController:SetSelectedState("show")
						arg_265_1.musicAnimator_:Play("open", 0, 0)

						if arg_265_1.settingData.music_time ~= 0 then
							arg_265_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_265_1.settingData.music_time), function()
								if arg_265_1 == nil or isNil(arg_265_1.bgmTxt_) then
									return
								end

								arg_265_1.musicController:SetSelectedState("hide")
								arg_265_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_265_1.time_ and arg_265_1.time_ <= 0.133333333333333 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_enginerepair", "")
			end

			local var_268_4 = 0
			local var_268_5 = 0.175

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_6 = arg_265_1:GetWordFromCfg(121521065)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 7 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 7)

				if (7 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 7)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521065", "story_v_out_121521.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521065", "story_v_out_121521.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_121521", "121521065", "story_v_out_121521.awb")

						arg_265_1:RecordAudio("121521065", var_268_11)
						arg_265_1:RecordAudio("121521065", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_121521", "121521065", "story_v_out_121521.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_121521", "121521065", "story_v_out_121521.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play121521066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 121521066
		arg_270_1.duration_ = 9

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play121521067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 2 < arg_270_1.time_ and arg_270_1.time_ <= 2 + arg_273_0 then
				local var_273_0 = arg_270_1.bgs_.J12f

				arg_270_1.bgs_.J12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_1 = var_273_0:GetComponent("SpriteRenderer")

				if var_273_1 and var_273_1.sprite then
					local var_273_2 = 2 * (var_273_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_0.transform.localScale = Vector3.New(var_273_2 / var_273_1.sprite.bounds.size.y < var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x and var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x or var_273_2 / var_273_1.sprite.bounds.size.y, var_273_2 / var_273_1.sprite.bounds.size.y < var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x and var_273_2 * manager.ui.mainCameraCom_.aspect / var_273_1.sprite.bounds.size.x or var_273_2 / var_273_1.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "J12f" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_3 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_4 = 2

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_4 then
				local var_273_5 = Color.New(0, 0, 0)

				var_273_5.a = Mathf.Lerp(0, 1, (arg_270_1.time_ - var_273_3) / var_273_4)
				arg_270_1.mask_.color = var_273_5
			end

			if arg_270_1.time_ >= var_273_3 + var_273_4 and arg_270_1.time_ < var_273_3 + var_273_4 + arg_273_0 then
				local var_273_6 = Color.New(0, 0, 0)

				var_273_6.a = 1
				arg_270_1.mask_.color = var_273_6
			end

			local var_273_7 = 2

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_8 = 2

			if var_273_7 <= arg_270_1.time_ and arg_270_1.time_ < var_273_7 + var_273_8 then
				local var_273_9 = Color.New(1, 1, 1)

				var_273_9.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_7) / var_273_8)
				arg_270_1.mask_.color = var_273_9
			end

			if arg_270_1.time_ >= var_273_7 + var_273_8 and arg_270_1.time_ < var_273_7 + var_273_8 + arg_273_0 then
				local var_273_10 = Color.New(1, 1, 1)

				arg_270_1.mask_.enabled = false
				var_273_10.a = 0
				arg_270_1.mask_.color = var_273_10
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_12 = 4
			local var_273_13 = 0.975

			if 4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_12 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_14 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_14:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_15 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(121521066).content)

				arg_270_1.text_.text = var_273_15

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_17 = 39 <= 0 and var_273_13 or var_273_13 * (utf8.len(var_273_15) / 39)

				if (39 <= 0 and var_273_13 or var_273_13 * (utf8.len(var_273_15) / 39)) > 0 and var_273_13 < var_273_17 then
					arg_270_1.talkMaxDuration = var_273_17
					var_273_12 = var_273_12 + 0.3

					if var_273_17 + var_273_12 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_17 + var_273_12
					end
				end

				arg_270_1.text_.text = var_273_15
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_18 = var_273_12 + 0.3
			local var_273_19 = math.max(var_273_13, arg_270_1.talkMaxDuration)

			if var_273_12 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_18 + var_273_19 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_18) / var_273_19

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_18 + var_273_19 and arg_270_1.time_ < var_273_18 + var_273_19 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play121521067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 121521067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play121521068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 1.175

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(121521067).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 47 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 47)

				if (47 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 47)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play121521068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 121521068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play121521069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.95

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(121521068).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 38 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 38)

				if (38 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 38)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play121521069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 121521069
		arg_284_1.duration_ = 5.5

		local var_284_0 = {
			ja = 5.5,
			ko = 2.466666666666,
			zh = 2.466666666666
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play121521070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1084ui_story = arg_284_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).z)
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles = arg_284_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_284_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1084ui_story"].transform.position).z)
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1084ui_story"].transform.localEulerAngles = arg_284_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["1084ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1084ui_story == nil then
				arg_284_1.var_.characterEffect1084ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect1084ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1084ui_story then
				arg_284_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_287_4 = arg_284_1.actors_["1075ui_story"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1075ui_story = var_287_4.localPosition
			end

			local var_287_5 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_5 then
				var_287_4.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_284_1.time_ - 0) / var_287_5)
				var_287_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_4.position).x, (manager.ui.mainCamera.transform.position - var_287_4.position).y, (manager.ui.mainCamera.transform.position - var_287_4.position).z)
				var_287_4.localEulerAngles.z = 0
				var_287_4.localEulerAngles.x = 0
				var_287_4.localEulerAngles = var_287_4.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_5 and arg_284_1.time_ < 0 + var_287_5 + arg_287_0 then
				var_287_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_287_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_4.position).x, (manager.ui.mainCamera.transform.position - var_287_4.position).y, (manager.ui.mainCamera.transform.position - var_287_4.position).z)
				var_287_4.localEulerAngles.z = 0
				var_287_4.localEulerAngles.x = 0
				var_287_4.localEulerAngles = var_287_4.localEulerAngles
			end

			local var_287_6 = arg_284_1.actors_["1075ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_6) and arg_284_1.var_.characterEffect1075ui_story == nil then
				arg_284_1.var_.characterEffect1075ui_story = var_287_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_7 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 and not isNil(var_287_6) then
				if arg_284_1.var_.characterEffect1075ui_story and not isNil(var_287_6) then
					arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_7)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 and not isNil(var_287_6) and arg_284_1.var_.characterEffect1075ui_story then
				arg_284_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_287_8 = 0
			local var_287_9 = 0.15

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_10 = arg_284_1:GetWordFromCfg(121521069)
				local var_287_11 = arg_284_1:FormatText(var_287_10.content)

				arg_284_1.text_.text = var_287_11

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 6 <= 0 and var_287_9 or var_287_9 * (utf8.len(var_287_11) / 6)

				if (6 <= 0 and var_287_9 or var_287_9 * (utf8.len(var_287_11) / 6)) > 0 and var_287_9 < var_287_13 then
					arg_284_1.talkMaxDuration = var_287_13

					if var_287_13 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_13 + var_287_8
					end
				end

				arg_284_1.text_.text = var_287_11
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521069", "story_v_out_121521.awb") ~= 0 then
					local var_287_14 = manager.audio:GetVoiceLength("story_v_out_121521", "121521069", "story_v_out_121521.awb") / 1000

					if var_287_14 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_8
					end

					if var_287_10.prefab_name ~= "" and arg_284_1.actors_[var_287_10.prefab_name] ~= nil then
						local var_287_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_10.prefab_name].transform, "story_v_out_121521", "121521069", "story_v_out_121521.awb")

						arg_284_1:RecordAudio("121521069", var_287_15)
						arg_284_1:RecordAudio("121521069", var_287_15)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_121521", "121521069", "story_v_out_121521.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_121521", "121521069", "story_v_out_121521.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_9, arg_284_1.talkMaxDuration)

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_8) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_8 + var_287_16 and arg_284_1.time_ < var_287_8 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play121521070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 121521070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play121521071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) and arg_288_1.var_.characterEffect1084ui_story == nil then
				arg_288_1.var_.characterEffect1084ui_story = arg_288_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) then
				if arg_288_1.var_.characterEffect1084ui_story and not isNil(arg_288_1.actors_["1084ui_story"]) then
					arg_288_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_0)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1084ui_story"]) and arg_288_1.var_.characterEffect1084ui_story then
				arg_288_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			local var_291_2 = 0
			local var_291_3 = 0.375

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_4 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(121521070).content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_6 = 15 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 15)

				if (15 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 15)) > 0 and var_291_3 < var_291_6 then
					arg_288_1.talkMaxDuration = var_291_6

					if var_291_6 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_6 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_7 and arg_288_1.time_ < var_291_2 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play121521071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 121521071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play121521072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.425

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(121521071).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 17 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 17)

				if (17 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 17)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play121521072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 121521072
		arg_296_1.duration_ = 11.6

		local var_296_0 = {
			ja = 8.866,
			ko = 11.6,
			zh = 11.6
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play121521073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1075ui_story"]) and arg_296_1.var_.characterEffect1075ui_story == nil then
				arg_296_1.var_.characterEffect1075ui_story = arg_296_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1075ui_story"]) then
				if arg_296_1.var_.characterEffect1075ui_story and not isNil(arg_296_1.actors_["1075ui_story"]) then
					arg_296_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1075ui_story"]) and arg_296_1.var_.characterEffect1075ui_story then
				arg_296_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_2 = 0
			local var_299_3 = 1.4

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_4 = arg_296_1:GetWordFromCfg(121521072)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 56 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 56)

				if (56 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 56)) > 0 and var_299_3 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521072", "story_v_out_121521.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521072", "story_v_out_121521.awb") / 1000

					if var_299_8 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_2
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_out_121521", "121521072", "story_v_out_121521.awb")

						arg_296_1:RecordAudio("121521072", var_299_9)
						arg_296_1:RecordAudio("121521072", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_121521", "121521072", "story_v_out_121521.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_121521", "121521072", "story_v_out_121521.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_10 and arg_296_1.time_ < var_299_2 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play121521073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 121521073
		arg_300_1.duration_ = 12.43

		local var_300_0 = {
			ja = 12.333,
			ko = 12.433,
			zh = 12.433
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play121521074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_303_0 = 0
			local var_303_1 = 1.225

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(121521073)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 49 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 49)

				if (49 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 49)) > 0 and var_303_1 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521073", "story_v_out_121521.awb") ~= 0 then
					local var_303_6 = manager.audio:GetVoiceLength("story_v_out_121521", "121521073", "story_v_out_121521.awb") / 1000

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end

					if var_303_2.prefab_name ~= "" and arg_300_1.actors_[var_303_2.prefab_name] ~= nil then
						local var_303_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_2.prefab_name].transform, "story_v_out_121521", "121521073", "story_v_out_121521.awb")

						arg_300_1:RecordAudio("121521073", var_303_7)
						arg_300_1:RecordAudio("121521073", var_303_7)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_121521", "121521073", "story_v_out_121521.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_121521", "121521073", "story_v_out_121521.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_8 and arg_300_1.time_ < var_303_0 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play121521074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 121521074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play121521075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1075ui_story"]) and arg_304_1.var_.characterEffect1075ui_story == nil then
				arg_304_1.var_.characterEffect1075ui_story = arg_304_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1075ui_story"]) then
				if arg_304_1.var_.characterEffect1075ui_story and not isNil(arg_304_1.actors_["1075ui_story"]) then
					arg_304_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1075ui_story"]) and arg_304_1.var_.characterEffect1075ui_story then
				arg_304_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.225

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(121521074).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 9 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 9)

				if (9 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 9)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play121521075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 121521075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play121521076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1075ui_story = arg_308_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).z)
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles = arg_308_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1075ui_story"].transform.position).z)
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1075ui_story"].transform.localEulerAngles = arg_308_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_311_1 = arg_308_1.actors_["1075ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1075ui_story == nil then
				arg_308_1.var_.characterEffect1075ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect1075ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_2)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1075ui_story then
				arg_308_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_311_3 = arg_308_1.actors_["1084ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1084ui_story = var_311_3.localPosition
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_3.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_4)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_3.localPosition = Vector3.New(0, 100, 0)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			local var_311_5 = arg_308_1.actors_["1084ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1084ui_story == nil then
				arg_308_1.var_.characterEffect1084ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.characterEffect1084ui_story and not isNil(var_311_5) then
					arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_6)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1084ui_story then
				arg_308_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_311_7 = 0
			local var_311_8 = 0.425

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_7 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_9 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(121521075).content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 17 <= 0 and var_311_8 or var_311_8 * (utf8.len(var_311_9) / 17)

				if (17 <= 0 and var_311_8 or var_311_8 * (utf8.len(var_311_9) / 17)) > 0 and var_311_8 < var_311_11 then
					arg_308_1.talkMaxDuration = var_311_11

					if var_311_11 + var_311_7 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_7
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_12 = math.max(var_311_8, arg_308_1.talkMaxDuration)

			if var_311_7 <= arg_308_1.time_ and arg_308_1.time_ < var_311_7 + var_311_12 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_7) / var_311_12

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_7 + var_311_12 and arg_308_1.time_ < var_311_7 + var_311_12 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play121521076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 121521076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play121521077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 1.425

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(121521076).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 57 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 57)

				if (57 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 57)) > 0 and var_315_0 < var_315_3 then
					arg_312_1.talkMaxDuration = var_315_3

					if var_315_3 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_3 + 0
					end
				end

				arg_312_1.text_.text = var_315_1
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_4 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_4

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play121521077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 121521077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play121521078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_cannonhit1", "")
			end

			local var_319_1 = 0
			local var_319_2 = 0.925

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(121521077).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 37 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 37)

				if (37 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 37)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play121521078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 121521078
		arg_320_1.duration_ = 7.67

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play121521079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_0 = 1.5

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				local var_323_1 = Color.New(1, 1, 1)

				var_323_1.a = Mathf.Lerp(1, 0, (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.mask_.color = var_323_1
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				local var_323_2 = Color.New(1, 1, 1)

				arg_320_1.mask_.enabled = false
				var_323_2.a = 0
				arg_320_1.mask_.color = var_323_2
			end

			local var_323_3 = 1.6682193024084

			if 1.6682193024084 < arg_320_1.time_ and arg_320_1.time_ <= var_323_3 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_4 = 1

			if var_323_3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_3 + var_323_4 then
				local var_323_5 = Color.New(1, 1, 1)

				var_323_5.a = Mathf.Lerp(1, 0, (arg_320_1.time_ - var_323_3) / var_323_4)
				arg_320_1.mask_.color = var_323_5
			end

			if arg_320_1.time_ >= var_323_3 + var_323_4 and arg_320_1.time_ < var_323_3 + var_323_4 + arg_323_0 then
				local var_323_6 = Color.New(1, 1, 1)

				arg_320_1.mask_.enabled = false
				var_323_6.a = 0
				arg_320_1.mask_.color = var_323_6
			end

			local var_323_7 = manager.ui.mainCamera.transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = var_323_7.localPosition
			end

			local var_323_8 = 1.5

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_8 then
				local var_323_9, var_323_10 = math.modf((arg_320_1.time_ - 0) / 0.066)

				var_323_7.localPosition = Vector3.New(var_323_10 * 0.13, var_323_10 * 0.13, var_323_10 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= 0 + var_323_8 and arg_320_1.time_ < 0 + var_323_8 + arg_323_0 then
				var_323_7.localPosition = arg_320_1.var_.shakeOldPos
			end

			local var_323_11 = manager.ui.mainCamera.transform

			if 1.66666666666667 < arg_320_1.time_ and arg_320_1.time_ <= 1.66666666666667 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = var_323_11.localPosition
			end

			local var_323_12 = 1.00155263574173

			if 1.66666666666667 <= arg_320_1.time_ and arg_320_1.time_ < 1.66666666666667 + var_323_12 then
				local var_323_13, var_323_14 = math.modf((arg_320_1.time_ - 1.66666666666667) / 0.066)

				var_323_11.localPosition = Vector3.New(var_323_14 * 0.13, var_323_14 * 0.13, var_323_14 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= 1.66666666666667 + var_323_12 and arg_320_1.time_ < 1.66666666666667 + var_323_12 + arg_323_0 then
				var_323_11.localPosition = arg_320_1.var_.shakeOldPos
			end

			local var_323_15 = 0

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_15 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			if arg_320_1.time_ >= var_323_15 + 2.6682193024084 and arg_320_1.time_ < var_323_15 + 2.6682193024084 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_16 = 2.6682193024084
			local var_323_17 = 1.325

			if 2.6682193024084 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_18 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_18:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_19 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(121521078).content)

				arg_320_1.text_.text = var_323_19

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_21 = 54 <= 0 and var_323_17 or var_323_17 * (utf8.len(var_323_19) / 54)

				if (54 <= 0 and var_323_17 or var_323_17 * (utf8.len(var_323_19) / 54)) > 0 and var_323_17 < var_323_21 then
					arg_320_1.talkMaxDuration = var_323_21
					var_323_16 = var_323_16 + 0.3

					if var_323_21 + var_323_16 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_21 + var_323_16
					end
				end

				arg_320_1.text_.text = var_323_19
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_22 = var_323_16 + 0.3
			local var_323_23 = math.max(var_323_17, arg_320_1.talkMaxDuration)

			if var_323_16 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_22 + var_323_23 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_22) / var_323_23

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_22 + var_323_23 and arg_320_1.time_ < var_323_22 + var_323_23 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play121521079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 121521079
		arg_326_1.duration_ = 2.93

		local var_326_0 = {
			ja = 2.933,
			ko = 1.866,
			zh = 1.866
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play121521080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.225

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[406].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(121521079)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 9 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 9)

				if (9 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 9)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521079", "story_v_out_121521.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521079", "story_v_out_121521.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_121521", "121521079", "story_v_out_121521.awb")

						arg_326_1:RecordAudio("121521079", var_329_6)
						arg_326_1:RecordAudio("121521079", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_121521", "121521079", "story_v_out_121521.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_121521", "121521079", "story_v_out_121521.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play121521080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 121521080
		arg_330_1.duration_ = 6.73

		local var_330_0 = {
			ja = 6.733,
			ko = 2.9,
			zh = 2.9
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play121521081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.425

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:GetWordFromCfg(121521080)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 17 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 17)

				if (17 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 17)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521080", "story_v_out_121521.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521080", "story_v_out_121521.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_121521", "121521080", "story_v_out_121521.awb")

						arg_330_1:RecordAudio("121521080", var_333_6)
						arg_330_1:RecordAudio("121521080", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_121521", "121521080", "story_v_out_121521.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_121521", "121521080", "story_v_out_121521.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play121521081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 121521081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play121521082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.8

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(121521081).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 32 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 32)

				if (32 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 32)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play121521082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 121521082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play121521083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 1.125

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(121521082).content)

				arg_338_1.text_.text = var_341_1

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_3 = 45 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 45)

				if (45 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_1) / 45)) > 0 and var_341_0 < var_341_3 then
					arg_338_1.talkMaxDuration = var_341_3

					if var_341_3 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_3 + 0
					end
				end

				arg_338_1.text_.text = var_341_1
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_4 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_4

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play121521083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 121521083
		arg_342_1.duration_ = 10.17

		local var_342_0 = {
			ja = 8.666,
			ko = 10.166,
			zh = 10.166
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play121521084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 1.375

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[406].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:GetWordFromCfg(121521083)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 55 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 55)

				if (55 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 55)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521083", "story_v_out_121521.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521083", "story_v_out_121521.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_out_121521", "121521083", "story_v_out_121521.awb")

						arg_342_1:RecordAudio("121521083", var_345_6)
						arg_342_1:RecordAudio("121521083", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_121521", "121521083", "story_v_out_121521.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_121521", "121521083", "story_v_out_121521.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play121521084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 121521084
		arg_346_1.duration_ = 9.83

		local var_346_0 = {
			ja = 9.833,
			ko = 6.666,
			zh = 6.666
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play121521085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.9

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[406].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:GetWordFromCfg(121521084)
				local var_349_2 = arg_346_1:FormatText(var_349_1.content)

				arg_346_1.text_.text = var_349_2

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 36 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 36)

				if (36 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 36)) > 0 and var_349_0 < var_349_4 then
					arg_346_1.talkMaxDuration = var_349_4

					if var_349_4 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_4 + 0
					end
				end

				arg_346_1.text_.text = var_349_2
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521084", "story_v_out_121521.awb") ~= 0 then
					local var_349_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521084", "story_v_out_121521.awb") / 1000

					if var_349_5 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + 0
					end

					if var_349_1.prefab_name ~= "" and arg_346_1.actors_[var_349_1.prefab_name] ~= nil then
						local var_349_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_1.prefab_name].transform, "story_v_out_121521", "121521084", "story_v_out_121521.awb")

						arg_346_1:RecordAudio("121521084", var_349_6)
						arg_346_1:RecordAudio("121521084", var_349_6)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_121521", "121521084", "story_v_out_121521.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_121521", "121521084", "story_v_out_121521.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play121521085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 121521085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play121521086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.875

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(121521085).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 35 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 35)

				if (35 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 35)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play121521086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 121521086
		arg_354_1.duration_ = 3.53

		local var_354_0 = {
			ja = 3.533,
			ko = 3.166,
			zh = 3.166
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play121521087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1075ui_story = arg_354_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).z)
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles = arg_354_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_354_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1075ui_story"].transform.position).z)
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1075ui_story"].transform.localEulerAngles = arg_354_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["1075ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1075ui_story == nil then
				arg_354_1.var_.characterEffect1075ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect1075ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1075ui_story then
				arg_354_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_357_4 = 0
			local var_357_5 = 0.375

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(121521086)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 15 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 15)

				if (15 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 15)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521086", "story_v_out_121521.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521086", "story_v_out_121521.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_out_121521", "121521086", "story_v_out_121521.awb")

						arg_354_1:RecordAudio("121521086", var_357_11)
						arg_354_1:RecordAudio("121521086", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_121521", "121521086", "story_v_out_121521.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_121521", "121521086", "story_v_out_121521.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_12 and arg_354_1.time_ < var_357_4 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play121521087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 121521087
		arg_358_1.duration_ = 17.9

		local var_358_0 = {
			ja = 17.9,
			ko = 12.266,
			zh = 12.266
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play121521088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1075ui_story"]) and arg_358_1.var_.characterEffect1075ui_story == nil then
				arg_358_1.var_.characterEffect1075ui_story = arg_358_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1075ui_story"]) then
				if arg_358_1.var_.characterEffect1075ui_story and not isNil(arg_358_1.actors_["1075ui_story"]) then
					arg_358_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1075ui_story"]) and arg_358_1.var_.characterEffect1075ui_story then
				arg_358_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 1.25

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[406].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifang")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(121521087)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_6 = 50 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_4) / 50)

				if (50 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_4) / 50)) > 0 and var_361_2 < var_361_6 then
					arg_358_1.talkMaxDuration = var_361_6

					if var_361_6 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_6 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521087", "story_v_out_121521.awb") ~= 0 then
					local var_361_7 = manager.audio:GetVoiceLength("story_v_out_121521", "121521087", "story_v_out_121521.awb") / 1000

					if var_361_7 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_1
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_out_121521", "121521087", "story_v_out_121521.awb")

						arg_358_1:RecordAudio("121521087", var_361_8)
						arg_358_1:RecordAudio("121521087", var_361_8)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_121521", "121521087", "story_v_out_121521.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_121521", "121521087", "story_v_out_121521.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_9 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_9 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_9

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_9 and arg_358_1.time_ < var_361_1 + var_361_9 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play121521088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 121521088
		arg_362_1.duration_ = 10.03

		local var_362_0 = {
			ja = 10.033,
			ko = 5.566,
			zh = 5.566
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play121521089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1075ui_story"]) and arg_362_1.var_.characterEffect1075ui_story == nil then
				arg_362_1.var_.characterEffect1075ui_story = arg_362_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1075ui_story"]) then
				if arg_362_1.var_.characterEffect1075ui_story and not isNil(arg_362_1.actors_["1075ui_story"]) then
					arg_362_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1075ui_story"]) and arg_362_1.var_.characterEffect1075ui_story then
				arg_362_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_365_2 = 0
			local var_365_3 = 0.575

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:GetWordFromCfg(121521088)
				local var_365_5 = arg_362_1:FormatText(var_365_4.content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 23 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 23)

				if (23 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 23)) > 0 and var_365_3 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521088", "story_v_out_121521.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_121521", "121521088", "story_v_out_121521.awb") / 1000

					if var_365_8 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_2
					end

					if var_365_4.prefab_name ~= "" and arg_362_1.actors_[var_365_4.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_4.prefab_name].transform, "story_v_out_121521", "121521088", "story_v_out_121521.awb")

						arg_362_1:RecordAudio("121521088", var_365_9)
						arg_362_1:RecordAudio("121521088", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_121521", "121521088", "story_v_out_121521.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_121521", "121521088", "story_v_out_121521.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_3, arg_362_1.talkMaxDuration)

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_2) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_2 + var_365_10 and arg_362_1.time_ < var_365_2 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play121521089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 121521089
		arg_366_1.duration_ = 9.23

		local var_366_0 = {
			ja = 5.633,
			ko = 9.233,
			zh = 9.233
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play121521090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 1.1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:GetWordFromCfg(121521089)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 44 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 44)

				if (44 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 44)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521089", "story_v_out_121521.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_out_121521", "121521089", "story_v_out_121521.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_out_121521", "121521089", "story_v_out_121521.awb")

						arg_366_1:RecordAudio("121521089", var_369_6)
						arg_366_1:RecordAudio("121521089", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_121521", "121521089", "story_v_out_121521.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_121521", "121521089", "story_v_out_121521.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play121521090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 121521090
		arg_370_1.duration_ = 8.5

		local var_370_0 = {
			ja = 8.5,
			ko = 6.4,
			zh = 6.4
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play121521091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1075ui_story = arg_370_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).z)
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles = arg_370_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_370_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1075ui_story"].transform.position).z)
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1075ui_story"].transform.localEulerAngles = arg_370_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_373_1 = arg_370_1.actors_["1075ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1075ui_story == nil then
				arg_370_1.var_.characterEffect1075ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect1075ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_2)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1075ui_story then
				arg_370_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_373_3 = manager.ui.mainCamera.transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.shakeOldPos = var_373_3.localPosition
			end

			local var_373_4 = 0.6

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				local var_373_5, var_373_6 = math.modf((arg_370_1.time_ - 0) / 0.066)

				var_373_3.localPosition = Vector3.New(var_373_6 * 0.13, var_373_6 * 0.13, var_373_6 * 0.13) + arg_370_1.var_.shakeOldPos
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				var_373_3.localPosition = arg_370_1.var_.shakeOldPos
			end

			local var_373_7 = 0

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_7 + arg_373_0 then
				arg_370_1.allBtn_.enabled = false
			end

			if arg_370_1.time_ >= var_373_7 + 0.6 and arg_370_1.time_ < var_373_7 + 0.6 + arg_373_0 then
				arg_370_1.allBtn_.enabled = true
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_17", "se_story_17_messenger", "")
			end

			local var_373_9 = 0
			local var_373_10 = 0.7

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_11 = arg_370_1:GetWordFromCfg(121521090)
				local var_373_12 = arg_370_1:FormatText(var_373_11.content)

				arg_370_1.text_.text = var_373_12

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_14 = 28 <= 0 and var_373_10 or var_373_10 * (utf8.len(var_373_12) / 28)

				if (28 <= 0 and var_373_10 or var_373_10 * (utf8.len(var_373_12) / 28)) > 0 and var_373_10 < var_373_14 then
					arg_370_1.talkMaxDuration = var_373_14

					if var_373_14 + var_373_9 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_14 + var_373_9
					end
				end

				arg_370_1.text_.text = var_373_12
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521090", "story_v_out_121521.awb") ~= 0 then
					local var_373_15 = manager.audio:GetVoiceLength("story_v_out_121521", "121521090", "story_v_out_121521.awb") / 1000

					if var_373_15 + var_373_9 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_15 + var_373_9
					end

					if var_373_11.prefab_name ~= "" and arg_370_1.actors_[var_373_11.prefab_name] ~= nil then
						local var_373_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_11.prefab_name].transform, "story_v_out_121521", "121521090", "story_v_out_121521.awb")

						arg_370_1:RecordAudio("121521090", var_373_16)
						arg_370_1:RecordAudio("121521090", var_373_16)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_121521", "121521090", "story_v_out_121521.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_121521", "121521090", "story_v_out_121521.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_17 = math.max(var_373_10, arg_370_1.talkMaxDuration)

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_17 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_9) / var_373_17

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_9 + var_373_17 and arg_370_1.time_ < var_373_9 + var_373_17 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play121521091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 121521091
		arg_374_1.duration_ = 5.3

		local var_374_0 = {
			ja = 5.3,
			ko = 4.066,
			zh = 4.066
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play121521092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_warnning", "")
			end

			local var_377_1 = 0
			local var_377_2 = 0.425

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:GetWordFromCfg(121521091)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_6 = 17 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_4) / 17)

				if (17 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_4) / 17)) > 0 and var_377_2 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_1
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521091", "story_v_out_121521.awb") ~= 0 then
					local var_377_7 = manager.audio:GetVoiceLength("story_v_out_121521", "121521091", "story_v_out_121521.awb") / 1000

					if var_377_7 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_1
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_out_121521", "121521091", "story_v_out_121521.awb")

						arg_374_1:RecordAudio("121521091", var_377_8)
						arg_374_1:RecordAudio("121521091", var_377_8)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_121521", "121521091", "story_v_out_121521.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_121521", "121521091", "story_v_out_121521.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_9 = math.max(var_377_2, arg_374_1.talkMaxDuration)

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_9 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_1) / var_377_9

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_1 + var_377_9 and arg_374_1.time_ < var_377_1 + var_377_9 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play121521092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 121521092
		arg_378_1.duration_ = 2.63

		local var_378_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play121521093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1084ui_story = arg_378_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_381_1 = arg_378_1.actors_["1084ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1084ui_story == nil then
				arg_378_1.var_.characterEffect1084ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect1084ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1084ui_story then
				arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_381_4 = 0
			local var_381_5 = 0.1

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_6 = arg_378_1:GetWordFromCfg(121521092)
				local var_381_7 = arg_378_1:FormatText(var_381_6.content)

				arg_378_1.text_.text = var_381_7

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 4 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 4)

				if (4 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 4)) > 0 and var_381_5 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_7
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121521", "121521092", "story_v_out_121521.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_out_121521", "121521092", "story_v_out_121521.awb") / 1000

					if var_381_10 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_4
					end

					if var_381_6.prefab_name ~= "" and arg_378_1.actors_[var_381_6.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_6.prefab_name].transform, "story_v_out_121521", "121521092", "story_v_out_121521.awb")

						arg_378_1:RecordAudio("121521092", var_381_11)
						arg_378_1:RecordAudio("121521092", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_121521", "121521092", "story_v_out_121521.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_121521", "121521092", "story_v_out_121521.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_12 and arg_378_1.time_ < var_381_4 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play121521093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 121521093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play121521094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1084ui_story = arg_382_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).z)
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles = arg_382_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_382_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1084ui_story"].transform.position).z)
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1084ui_story"].transform.localEulerAngles = arg_382_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_385_1 = arg_382_1.actors_["1084ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1084ui_story == nil then
				arg_382_1.var_.characterEffect1084ui_story = var_385_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_2 and not isNil(var_385_1) then
				if arg_382_1.var_.characterEffect1084ui_story and not isNil(var_385_1) then
					arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_2)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_2 and arg_382_1.time_ < 0 + var_385_2 + arg_385_0 and not isNil(var_385_1) and arg_382_1.var_.characterEffect1084ui_story then
				arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_385_3 = 0
			local var_385_4 = 1.25

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_3 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_5 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(121521093).content)

				arg_382_1.text_.text = var_385_5

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_7 = 50 <= 0 and var_385_4 or var_385_4 * (utf8.len(var_385_5) / 50)

				if (50 <= 0 and var_385_4 or var_385_4 * (utf8.len(var_385_5) / 50)) > 0 and var_385_4 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_3 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_3
					end
				end

				arg_382_1.text_.text = var_385_5
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_4, arg_382_1.talkMaxDuration)

			if var_385_3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_3 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_3) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_3 + var_385_8 and arg_382_1.time_ < var_385_3 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play121521094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 121521094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play121521095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0.7 < arg_386_1.time_ and arg_386_1.time_ <= 0.7 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_monsterappear", "")
			end

			local var_389_1 = 0
			local var_389_2 = 0.65

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(121521094).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 26 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 26)

				if (26 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 26)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play121521095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 121521095
		arg_390_1.duration_ = 7

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play121521096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_9000

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_0 = 2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				local var_393_1 = Color.New(1, 1, 1)

				var_393_1.a = Mathf.Lerp(1, 0, (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.mask_.color = var_393_1
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				local var_393_2 = Color.New(1, 1, 1)

				arg_390_1.mask_.enabled = false
				var_393_2.a = 0
				arg_390_1.mask_.color = var_393_2
			end

			local var_393_3 = manager.ui.mainCamera.transform

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.shakeOldPos = var_393_3.localPosition
			end

			local var_393_4 = 2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				local var_393_5, var_393_6 = math.modf((arg_390_1.time_ - 0) / 0.066)

				var_393_3.localPosition = Vector3.New(var_393_6 * 0.13, var_393_6 * 0.13, var_393_6 * 0.13) + arg_390_1.var_.shakeOldPos
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				var_393_3.localPosition = arg_390_1.var_.shakeOldPos
			end

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= 2 + arg_393_0 then
				local var_393_7 = arg_390_1.var_.effectkuangzhen1

				if not arg_390_1.var_.effectkuangzhen1 then
					var_393_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_393_7.name = "kuangzhen1"
					arg_390_1.var_.effectkuangzhen1 = var_393_7
				else
					var_393_7.transform:SetParent(var_393_9000)
				end

				var_393_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_393_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_393_9 = 2
			local var_393_10 = 1.425

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_11 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(121521095).content)

				arg_390_1.text_.text = var_393_11

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_13 = 57 <= 0 and var_393_10 or var_393_10 * (utf8.len(var_393_11) / 57)

				if (57 <= 0 and var_393_10 or var_393_10 * (utf8.len(var_393_11) / 57)) > 0 and var_393_10 < var_393_13 then
					arg_390_1.talkMaxDuration = var_393_13

					if var_393_13 + var_393_9 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_9
					end
				end

				arg_390_1.text_.text = var_393_11
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_14 = math.max(var_393_10, arg_390_1.talkMaxDuration)

			if var_393_9 <= arg_390_1.time_ and arg_390_1.time_ < var_393_9 + var_393_14 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_9) / var_393_14

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_9 + var_393_14 and arg_390_1.time_ < var_393_9 + var_393_14 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play121521096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 121521096
		arg_394_1.duration_ = 7

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
			arg_394_1.auto_ = false
		end

		function arg_394_1.playNext_(arg_396_0)
			arg_394_1.onStoryFinished_()
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 2 < arg_394_1.time_ and arg_394_1.time_ <= 2 + arg_397_0 then
				local var_397_0 = arg_394_1.bgs_.STblack

				arg_394_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_397_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_397_1 = var_397_0:GetComponent("SpriteRenderer")

				if var_397_1 and var_397_1.sprite then
					local var_397_2 = 2 * (var_397_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_397_0.transform.localScale = Vector3.New(var_397_2 / var_397_1.sprite.bounds.size.y < var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x and var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x or var_397_2 / var_397_1.sprite.bounds.size.y, var_397_2 / var_397_1.sprite.bounds.size.y < var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x and var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x or var_397_2 / var_397_1.sprite.bounds.size.y, 0)
				end

				for iter_397_0, iter_397_1 in pairs(arg_394_1.bgs_) do
					if iter_397_0 ~= "STblack" then
						iter_397_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_397_3 = 0

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_3 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_4 = 2

			if var_397_3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_3 + var_397_4 then
				local var_397_5 = Color.New(0, 0, 0)

				var_397_5.a = Mathf.Lerp(0, 1, (arg_394_1.time_ - var_397_3) / var_397_4)
				arg_394_1.mask_.color = var_397_5
			end

			if arg_394_1.time_ >= var_397_3 + var_397_4 and arg_394_1.time_ < var_397_3 + var_397_4 + arg_397_0 then
				local var_397_6 = Color.New(0, 0, 0)

				var_397_6.a = 1
				arg_394_1.mask_.color = var_397_6
			end

			local var_397_7 = 2

			if 2 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_8 = 0.5

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_8 then
				local var_397_9 = Color.New(0, 0, 0)

				var_397_9.a = Mathf.Lerp(1, 0, (arg_394_1.time_ - var_397_7) / var_397_8)
				arg_394_1.mask_.color = var_397_9
			end

			if arg_394_1.time_ >= var_397_7 + var_397_8 and arg_394_1.time_ < var_397_7 + var_397_8 + arg_397_0 then
				local var_397_10 = Color.New(0, 0, 0)

				arg_394_1.mask_.enabled = false
				var_397_10.a = 0
				arg_394_1.mask_.color = var_397_10
			end

			if 2 < arg_394_1.time_ and arg_394_1.time_ <= 2 + arg_397_0 then
				if arg_394_1.var_.effectkuaangzhen2 then
					Object.Destroy(arg_394_1.var_.effectkuaangzhen2)

					arg_394_1.var_.effectkuaangzhen2 = nil
				end
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_12 = 2
			local var_397_13 = 0.125

			if 2 < arg_394_1.time_ and arg_394_1.time_ <= var_397_12 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_14 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_14:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_15 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(121521096).content)

				arg_394_1.text_.text = var_397_15

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_17 = 5 <= 0 and var_397_13 or var_397_13 * (utf8.len(var_397_15) / 5)

				if (5 <= 0 and var_397_13 or var_397_13 * (utf8.len(var_397_15) / 5)) > 0 and var_397_13 < var_397_17 then
					arg_394_1.talkMaxDuration = var_397_17
					var_397_12 = var_397_12 + 0.3

					if var_397_17 + var_397_12 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_17 + var_397_12
					end
				end

				arg_394_1.text_.text = var_397_15
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_18 = var_397_12 + 0.3
			local var_397_19 = math.max(var_397_13, arg_394_1.talkMaxDuration)

			if var_397_12 + 0.3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_18 + var_397_19 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_18) / var_397_19

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_18 + var_397_19 and arg_394_1.time_ < var_397_18 + var_397_19 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J12f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J12g",
		"TextureConfig/Background/XH0306"
	},
	voices = {
		"story_v_out_121521.awb"
	}
}
