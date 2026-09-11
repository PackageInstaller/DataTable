return {
	Play1107003001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107003001
		arg_1_1.duration_ = 5.8

		local var_1_0 = {
			zh = 4.633,
			ja = 5.8
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107003002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST44 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST44")
				var_4_0.name = "ST44"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST44 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST44

				arg_1_1.bgs_.ST44.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST44" then
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

			local var_4_8 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1070ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1070ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.95, -6.05)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1070ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			local var_4_20 = 2
			local var_4_21 = 0.5

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(1107003001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 20 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 20)

				if (20 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 20)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003001", "story_v_side_new_1107003.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003001", "story_v_side_new_1107003.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_side_new_1107003", "1107003001", "story_v_side_new_1107003.awb")

						arg_1_1:RecordAudio("1107003001", var_4_28)
						arg_1_1:RecordAudio("1107003001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003001", "story_v_side_new_1107003.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003001", "story_v_side_new_1107003.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1107003002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1107003002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1107003003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = arg_8_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) then
				if arg_8_1.var_.characterEffect1070ui_story and not isNil(arg_8_1.actors_["1070ui_story"]) then
					arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1070ui_story"]) and arg_8_1.var_.characterEffect1070ui_story then
				arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1107003002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 13 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 13)

				if (13 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 13)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1107003003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1107003003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1107003004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1107003003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 7 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 7)

				if (7 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 7)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1107003004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1107003004
		arg_16_1.duration_ = 2.2

		local var_16_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1107003005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) and arg_16_1.var_.characterEffect1070ui_story == nil then
				arg_16_1.var_.characterEffect1070ui_story = arg_16_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) then
				if arg_16_1.var_.characterEffect1070ui_story and not isNil(arg_16_1.actors_["1070ui_story"]) then
					arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1070ui_story"]) and arg_16_1.var_.characterEffect1070ui_story then
				arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_19_2 = 0
			local var_19_3 = 0.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(1107003004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 5 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 5)

				if (5 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_5) / 5)) > 0 and var_19_3 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003004", "story_v_side_new_1107003.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003004", "story_v_side_new_1107003.awb") / 1000

					if var_19_8 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_2
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_side_new_1107003", "1107003004", "story_v_side_new_1107003.awb")

						arg_16_1:RecordAudio("1107003004", var_19_9)
						arg_16_1:RecordAudio("1107003004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003004", "story_v_side_new_1107003.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003004", "story_v_side_new_1107003.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_10 and arg_16_1.time_ < var_19_2 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1107003005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1107003005
		arg_20_1.duration_ = 8.2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1107003006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0.266666666666667 < arg_20_1.time_ and arg_20_1.time_ <= 0.266666666666667 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_fire", "")
			end

			local var_23_1 = 0
			local var_23_2 = 0.8

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(1107003005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 32 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 32)

				if (32 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_4) / 32)) > 0 and var_23_2 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003005", "story_v_side_new_1107003.awb") ~= 0 then
					local var_23_7 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003005", "story_v_side_new_1107003.awb") / 1000

					if var_23_7 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_1
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_side_new_1107003", "1107003005", "story_v_side_new_1107003.awb")

						arg_20_1:RecordAudio("1107003005", var_23_8)
						arg_20_1:RecordAudio("1107003005", var_23_8)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003005", "story_v_side_new_1107003.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003005", "story_v_side_new_1107003.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_9 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_9 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_9

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_9 and arg_20_1.time_ < var_23_1 + var_23_9 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1107003006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1107003006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1107003007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) and arg_24_1.var_.characterEffect1070ui_story == nil then
				arg_24_1.var_.characterEffect1070ui_story = arg_24_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) then
				if arg_24_1.var_.characterEffect1070ui_story and not isNil(arg_24_1.actors_["1070ui_story"]) then
					arg_24_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1070ui_story"]) and arg_24_1.var_.characterEffect1070ui_story then
				arg_24_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1107003006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 12 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 12)

				if (12 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 12)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1107003007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1107003007
		arg_28_1.duration_ = 11.17

		local var_28_0 = {
			zh = 7.2,
			ja = 11.166
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1107003008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1070ui_story = arg_28_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).z)
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles = arg_28_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_28_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1070ui_story"].transform.position).z)
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1070ui_story"].transform.localEulerAngles = arg_28_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1070ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1070ui_story == nil then
				arg_28_1.var_.characterEffect1070ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1070ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1070ui_story then
				arg_28_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action427")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.925

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(1107003007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 37 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 37)

				if (37 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 37)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003007", "story_v_side_new_1107003.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003007", "story_v_side_new_1107003.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_side_new_1107003", "1107003007", "story_v_side_new_1107003.awb")

						arg_28_1:RecordAudio("1107003007", var_31_11)
						arg_28_1:RecordAudio("1107003007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003007", "story_v_side_new_1107003.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003007", "story_v_side_new_1107003.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play1107003008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1107003008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1107003009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story == nil then
				arg_32_1.var_.characterEffect1070ui_story = arg_32_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) then
				if arg_32_1.var_.characterEffect1070ui_story and not isNil(arg_32_1.actors_["1070ui_story"]) then
					arg_32_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1070ui_story"]) and arg_32_1.var_.characterEffect1070ui_story then
				arg_32_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(1107003008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 3 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 3)

				if (3 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 3)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1107003009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1107003009
		arg_36_1.duration_ = 3.67

		local var_36_0 = {
			zh = 2.399999999999,
			ja = 3.666
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1107003010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) and arg_36_1.var_.characterEffect1070ui_story == nil then
				arg_36_1.var_.characterEffect1070ui_story = arg_36_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) then
				if arg_36_1.var_.characterEffect1070ui_story and not isNil(arg_36_1.actors_["1070ui_story"]) then
					arg_36_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1070ui_story"]) and arg_36_1.var_.characterEffect1070ui_story then
				arg_36_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_39_2 = 0
			local var_39_3 = 0.325

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(1107003009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 13 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 13)

				if (13 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 13)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003009", "story_v_side_new_1107003.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003009", "story_v_side_new_1107003.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_side_new_1107003", "1107003009", "story_v_side_new_1107003.awb")

						arg_36_1:RecordAudio("1107003009", var_39_9)
						arg_36_1:RecordAudio("1107003009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003009", "story_v_side_new_1107003.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003009", "story_v_side_new_1107003.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1107003010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1107003010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1107003011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) and arg_40_1.var_.characterEffect1070ui_story == nil then
				arg_40_1.var_.characterEffect1070ui_story = arg_40_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) then
				if arg_40_1.var_.characterEffect1070ui_story and not isNil(arg_40_1.actors_["1070ui_story"]) then
					arg_40_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1070ui_story"]) and arg_40_1.var_.characterEffect1070ui_story then
				arg_40_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.1

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1107003010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 4 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 4)

				if (4 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 4)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1107003011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1107003011
		arg_44_1.duration_ = 3.97

		local var_44_0 = {
			zh = 2.833,
			ja = 3.966
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1107003012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1070ui_story"]) and arg_44_1.var_.characterEffect1070ui_story == nil then
				arg_44_1.var_.characterEffect1070ui_story = arg_44_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1070ui_story"]) then
				if arg_44_1.var_.characterEffect1070ui_story and not isNil(arg_44_1.actors_["1070ui_story"]) then
					arg_44_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1070ui_story"]) and arg_44_1.var_.characterEffect1070ui_story then
				arg_44_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_47_2 = 0
			local var_47_3 = 0.3

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(1107003011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 12 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 12)

				if (12 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 12)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003011", "story_v_side_new_1107003.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003011", "story_v_side_new_1107003.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_side_new_1107003", "1107003011", "story_v_side_new_1107003.awb")

						arg_44_1:RecordAudio("1107003011", var_47_9)
						arg_44_1:RecordAudio("1107003011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003011", "story_v_side_new_1107003.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003011", "story_v_side_new_1107003.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1107003012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1107003012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1107003013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story == nil then
				arg_48_1.var_.characterEffect1070ui_story = arg_48_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) then
				if arg_48_1.var_.characterEffect1070ui_story and not isNil(arg_48_1.actors_["1070ui_story"]) then
					arg_48_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1070ui_story"]) and arg_48_1.var_.characterEffect1070ui_story then
				arg_48_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_51_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_48_1.bgmTxt_.text ~= var_51_3 and arg_48_1.bgmTxt_.text ~= "" then
						if arg_48_1.bgmTxt2_.text ~= "" then
							arg_48_1.bgmTxt_.text = arg_48_1.bgmTxt2_.text
						end

						arg_48_1.bgmTxt2_.text = var_51_3

						arg_48_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_48_1.bgmTxt_.text = var_51_3
						arg_48_1.bgmTxt2_.text = var_51_3
					end

					if arg_48_1.bgmTimer then
						arg_48_1.bgmTimer:Stop()

						arg_48_1.bgmTimer = nil
					end

					if arg_48_1.settingData.show_music_name == 1 then
						arg_48_1.musicController:SetSelectedState("show")
						arg_48_1.musicAnimator_:Play("open", 0, 0)

						if arg_48_1.settingData.music_time ~= 0 then
							arg_48_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_48_1.settingData.music_time), function()
								if arg_48_1 == nil or isNil(arg_48_1.bgmTxt_) then
									return
								end

								arg_48_1.musicController:SetSelectedState("hide")
								arg_48_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_48_1.time_ and arg_48_1.time_ <= 0.166666666666667 + arg_51_0 then
				arg_48_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_51_6 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_48_1.bgmTxt_.text ~= var_51_6 and arg_48_1.bgmTxt_.text ~= "" then
						if arg_48_1.bgmTxt2_.text ~= "" then
							arg_48_1.bgmTxt_.text = arg_48_1.bgmTxt2_.text
						end

						arg_48_1.bgmTxt2_.text = var_51_6

						arg_48_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_48_1.bgmTxt_.text = var_51_6
						arg_48_1.bgmTxt2_.text = var_51_6
					end

					if arg_48_1.bgmTimer then
						arg_48_1.bgmTimer:Stop()

						arg_48_1.bgmTimer = nil
					end

					if arg_48_1.settingData.show_music_name == 1 then
						arg_48_1.musicController:SetSelectedState("show")
						arg_48_1.musicAnimator_:Play("open", 0, 0)

						if arg_48_1.settingData.music_time ~= 0 then
							arg_48_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_48_1.settingData.music_time), function()
								if arg_48_1 == nil or isNil(arg_48_1.bgmTxt_) then
									return
								end

								arg_48_1.musicController:SetSelectedState("hide")
								arg_48_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_51_7 = 0
			local var_51_8 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_9 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1107003012).content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 20 <= 0 and var_51_8 or var_51_8 * (utf8.len(var_51_9) / 20)

				if (20 <= 0 and var_51_8 or var_51_8 * (utf8.len(var_51_9) / 20)) > 0 and var_51_8 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_7 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_7
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_8, arg_48_1.talkMaxDuration)

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_7) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_7 + var_51_12 and arg_48_1.time_ < var_51_7 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1107003013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1107003013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1107003014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.775

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(1107003013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 31 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 31)

				if (31 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 31)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play1107003014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1107003014
		arg_58_1.duration_ = 5.03

		local var_58_0 = {
			zh = 3.5,
			ja = 5.033
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1107003015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1070ui_story"]) and arg_58_1.var_.characterEffect1070ui_story == nil then
				arg_58_1.var_.characterEffect1070ui_story = arg_58_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1070ui_story"]) then
				if arg_58_1.var_.characterEffect1070ui_story and not isNil(arg_58_1.actors_["1070ui_story"]) then
					arg_58_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1070ui_story"]) and arg_58_1.var_.characterEffect1070ui_story then
				arg_58_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_61_2 = 0
			local var_61_3 = 0.35

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(1107003014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 14 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 14)

				if (14 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 14)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003014", "story_v_side_new_1107003.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003014", "story_v_side_new_1107003.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_side_new_1107003", "1107003014", "story_v_side_new_1107003.awb")

						arg_58_1:RecordAudio("1107003014", var_61_9)
						arg_58_1:RecordAudio("1107003014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003014", "story_v_side_new_1107003.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003014", "story_v_side_new_1107003.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play1107003015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1107003015
		arg_62_1.duration_ = 7.4

		local var_62_0 = {
			zh = 6.833,
			ja = 7.4
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1107003016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_65_0 = 0
			local var_65_1 = 0.925

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(1107003015)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 37 <= 0 and var_65_1 or var_65_1 * (utf8.len(var_65_3) / 37)

				if (37 <= 0 and var_65_1 or var_65_1 * (utf8.len(var_65_3) / 37)) > 0 and var_65_1 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003015", "story_v_side_new_1107003.awb") ~= 0 then
					local var_65_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003015", "story_v_side_new_1107003.awb") / 1000

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end

					if var_65_2.prefab_name ~= "" and arg_62_1.actors_[var_65_2.prefab_name] ~= nil then
						local var_65_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_2.prefab_name].transform, "story_v_side_new_1107003", "1107003015", "story_v_side_new_1107003.awb")

						arg_62_1:RecordAudio("1107003015", var_65_7)
						arg_62_1:RecordAudio("1107003015", var_65_7)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003015", "story_v_side_new_1107003.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003015", "story_v_side_new_1107003.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_8 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_8 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_8

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_8 and arg_62_1.time_ < var_65_0 + var_65_8 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play1107003016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1107003016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1107003017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) and arg_66_1.var_.characterEffect1070ui_story == nil then
				arg_66_1.var_.characterEffect1070ui_story = arg_66_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) then
				if arg_66_1.var_.characterEffect1070ui_story and not isNil(arg_66_1.actors_["1070ui_story"]) then
					arg_66_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) and arg_66_1.var_.characterEffect1070ui_story then
				arg_66_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.9

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(1107003016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 36 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 36)

				if (36 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 36)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play1107003017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1107003017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1107003018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1070ui_story = arg_70_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).z)
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles = arg_70_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).z)
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles = arg_70_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_73_1 = 0
			local var_73_2 = 1.3

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(1107003017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 52 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 52)

				if (52 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 52)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play1107003018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1107003018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1107003019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.1

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(1107003018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 4 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 4)

				if (4 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 4)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1107003019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1107003019
		arg_78_1.duration_ = 6.07

		local var_78_0 = {
			zh = 6.033,
			ja = 6.066
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1107003020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) and arg_78_1.var_.characterEffect1070ui_story == nil then
				arg_78_1.var_.characterEffect1070ui_story = arg_78_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) then
				if arg_78_1.var_.characterEffect1070ui_story and not isNil(arg_78_1.actors_["1070ui_story"]) then
					arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) and arg_78_1.var_.characterEffect1070ui_story then
				arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_2 = arg_78_1.actors_["1070ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1070ui_story = var_81_2.localPosition
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_78_1.time_ - 0) / var_81_3)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			local var_81_4 = 0
			local var_81_5 = 0.7

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(1107003019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 28 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 28)

				if (28 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 28)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003019", "story_v_side_new_1107003.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003019", "story_v_side_new_1107003.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_side_new_1107003", "1107003019", "story_v_side_new_1107003.awb")

						arg_78_1:RecordAudio("1107003019", var_81_11)
						arg_78_1:RecordAudio("1107003019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003019", "story_v_side_new_1107003.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003019", "story_v_side_new_1107003.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play1107003020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1107003020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1107003021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1070ui_story"]) and arg_82_1.var_.characterEffect1070ui_story == nil then
				arg_82_1.var_.characterEffect1070ui_story = arg_82_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1070ui_story"]) then
				if arg_82_1.var_.characterEffect1070ui_story and not isNil(arg_82_1.actors_["1070ui_story"]) then
					arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1070ui_story"]) and arg_82_1.var_.characterEffect1070ui_story then
				arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.475

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(1107003020).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 19 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 19)

				if (19 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 19)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1107003021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1107003021
		arg_86_1.duration_ = 12.33

		local var_86_0 = {
			zh = 8.066,
			ja = 12.333
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1107003022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1070ui_story"]) and arg_86_1.var_.characterEffect1070ui_story == nil then
				arg_86_1.var_.characterEffect1070ui_story = arg_86_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1070ui_story"]) then
				if arg_86_1.var_.characterEffect1070ui_story and not isNil(arg_86_1.actors_["1070ui_story"]) then
					arg_86_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1070ui_story"]) and arg_86_1.var_.characterEffect1070ui_story then
				arg_86_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_89_2 = 0
			local var_89_3 = 1.1

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_4 = arg_86_1:GetWordFromCfg(1107003021)
				local var_89_5 = arg_86_1:FormatText(var_89_4.content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 44 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 44)

				if (44 <= 0 and var_89_3 or var_89_3 * (utf8.len(var_89_5) / 44)) > 0 and var_89_3 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_2
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003021", "story_v_side_new_1107003.awb") ~= 0 then
					local var_89_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003021", "story_v_side_new_1107003.awb") / 1000

					if var_89_8 + var_89_2 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_8 + var_89_2
					end

					if var_89_4.prefab_name ~= "" and arg_86_1.actors_[var_89_4.prefab_name] ~= nil then
						local var_89_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_4.prefab_name].transform, "story_v_side_new_1107003", "1107003021", "story_v_side_new_1107003.awb")

						arg_86_1:RecordAudio("1107003021", var_89_9)
						arg_86_1:RecordAudio("1107003021", var_89_9)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003021", "story_v_side_new_1107003.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003021", "story_v_side_new_1107003.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_3, arg_86_1.talkMaxDuration)

			if var_89_2 <= arg_86_1.time_ and arg_86_1.time_ < var_89_2 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_2) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_2 + var_89_10 and arg_86_1.time_ < var_89_2 + var_89_10 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1107003022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1107003022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1107003023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1070ui_story"]) and arg_90_1.var_.characterEffect1070ui_story == nil then
				arg_90_1.var_.characterEffect1070ui_story = arg_90_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1070ui_story"]) then
				if arg_90_1.var_.characterEffect1070ui_story and not isNil(arg_90_1.actors_["1070ui_story"]) then
					arg_90_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1070ui_story"]) and arg_90_1.var_.characterEffect1070ui_story then
				arg_90_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.075

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(1107003022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 3 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 3)

				if (3 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 3)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1107003023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1107003023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1107003024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.2

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(1107003023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 8 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 8)

				if (8 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 8)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1107003024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1107003024
		arg_98_1.duration_ = 3.63

		local var_98_0 = {
			zh = 2.399999999999,
			ja = 3.633
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1107003025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1070ui_story"]) and arg_98_1.var_.characterEffect1070ui_story == nil then
				arg_98_1.var_.characterEffect1070ui_story = arg_98_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1070ui_story"]) then
				if arg_98_1.var_.characterEffect1070ui_story and not isNil(arg_98_1.actors_["1070ui_story"]) then
					arg_98_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1070ui_story"]) and arg_98_1.var_.characterEffect1070ui_story then
				arg_98_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_101_2 = 0
			local var_101_3 = 0.125

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_4 = arg_98_1:GetWordFromCfg(1107003024)
				local var_101_5 = arg_98_1:FormatText(var_101_4.content)

				arg_98_1.text_.text = var_101_5

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 5 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 5)

				if (5 <= 0 and var_101_3 or var_101_3 * (utf8.len(var_101_5) / 5)) > 0 and var_101_3 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_5
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003024", "story_v_side_new_1107003.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003024", "story_v_side_new_1107003.awb") / 1000

					if var_101_8 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_2
					end

					if var_101_4.prefab_name ~= "" and arg_98_1.actors_[var_101_4.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_4.prefab_name].transform, "story_v_side_new_1107003", "1107003024", "story_v_side_new_1107003.awb")

						arg_98_1:RecordAudio("1107003024", var_101_9)
						arg_98_1:RecordAudio("1107003024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003024", "story_v_side_new_1107003.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003024", "story_v_side_new_1107003.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_10 and arg_98_1.time_ < var_101_2 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1107003025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1107003025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1107003026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) and arg_102_1.var_.characterEffect1070ui_story == nil then
				arg_102_1.var_.characterEffect1070ui_story = arg_102_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) then
				if arg_102_1.var_.characterEffect1070ui_story and not isNil(arg_102_1.actors_["1070ui_story"]) then
					arg_102_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) and arg_102_1.var_.characterEffect1070ui_story then
				arg_102_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 0.25

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(1107003025).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 10 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 10)

				if (10 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 10)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1107003026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1107003026
		arg_106_1.duration_ = 7.13

		local var_106_0 = {
			zh = 7.133,
			ja = 6.3
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1107003027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1070ui_story"]) and arg_106_1.var_.characterEffect1070ui_story == nil then
				arg_106_1.var_.characterEffect1070ui_story = arg_106_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1070ui_story"]) then
				if arg_106_1.var_.characterEffect1070ui_story and not isNil(arg_106_1.actors_["1070ui_story"]) then
					arg_106_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1070ui_story"]) and arg_106_1.var_.characterEffect1070ui_story then
				arg_106_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_109_2 = 0
			local var_109_3 = 0.9

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(1107003026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 36 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 36)

				if (36 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 36)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003026", "story_v_side_new_1107003.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003026", "story_v_side_new_1107003.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_side_new_1107003", "1107003026", "story_v_side_new_1107003.awb")

						arg_106_1:RecordAudio("1107003026", var_109_9)
						arg_106_1:RecordAudio("1107003026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003026", "story_v_side_new_1107003.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003026", "story_v_side_new_1107003.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1107003027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1107003027
		arg_110_1.duration_ = 11.1

		local var_110_0 = {
			zh = 9.133,
			ja = 11.1
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1107003028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_113_0 = 0
			local var_113_1 = 1.05

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(1107003027)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 42 <= 0 and var_113_1 or var_113_1 * (utf8.len(var_113_3) / 42)

				if (42 <= 0 and var_113_1 or var_113_1 * (utf8.len(var_113_3) / 42)) > 0 and var_113_1 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003027", "story_v_side_new_1107003.awb") ~= 0 then
					local var_113_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003027", "story_v_side_new_1107003.awb") / 1000

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end

					if var_113_2.prefab_name ~= "" and arg_110_1.actors_[var_113_2.prefab_name] ~= nil then
						local var_113_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_2.prefab_name].transform, "story_v_side_new_1107003", "1107003027", "story_v_side_new_1107003.awb")

						arg_110_1:RecordAudio("1107003027", var_113_7)
						arg_110_1:RecordAudio("1107003027", var_113_7)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003027", "story_v_side_new_1107003.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003027", "story_v_side_new_1107003.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_8 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_8 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_8

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_8 and arg_110_1.time_ < var_113_0 + var_113_8 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1107003028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1107003028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1107003029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1070ui_story"]) and arg_114_1.var_.characterEffect1070ui_story == nil then
				arg_114_1.var_.characterEffect1070ui_story = arg_114_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1070ui_story"]) then
				if arg_114_1.var_.characterEffect1070ui_story and not isNil(arg_114_1.actors_["1070ui_story"]) then
					arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1070ui_story"]) and arg_114_1.var_.characterEffect1070ui_story then
				arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_117_1 = 0
			local var_117_2 = 0.125

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(1107003028).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 5 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 5)

				if (5 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 5)) > 0 and var_117_2 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_6 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_6 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_6

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_6 and arg_114_1.time_ < var_117_1 + var_117_6 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1107003029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1107003029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1107003030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.35

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1107003029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 14)

				if (14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 14)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1107003030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1107003030
		arg_122_1.duration_ = 3.03

		local var_122_0 = {
			zh = 2.7,
			ja = 3.033
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1107003031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) and arg_122_1.var_.characterEffect1070ui_story == nil then
				arg_122_1.var_.characterEffect1070ui_story = arg_122_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) then
				if arg_122_1.var_.characterEffect1070ui_story and not isNil(arg_122_1.actors_["1070ui_story"]) then
					arg_122_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1070ui_story"]) and arg_122_1.var_.characterEffect1070ui_story then
				arg_122_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_125_2 = 0
			local var_125_3 = 0.425

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(1107003030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 17 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 17)

				if (17 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 17)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003030", "story_v_side_new_1107003.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003030", "story_v_side_new_1107003.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_side_new_1107003", "1107003030", "story_v_side_new_1107003.awb")

						arg_122_1:RecordAudio("1107003030", var_125_9)
						arg_122_1:RecordAudio("1107003030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003030", "story_v_side_new_1107003.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003030", "story_v_side_new_1107003.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1107003031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1107003031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1107003032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1070ui_story"]) and arg_126_1.var_.characterEffect1070ui_story == nil then
				arg_126_1.var_.characterEffect1070ui_story = arg_126_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1070ui_story"]) then
				if arg_126_1.var_.characterEffect1070ui_story and not isNil(arg_126_1.actors_["1070ui_story"]) then
					arg_126_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1070ui_story"]) and arg_126_1.var_.characterEffect1070ui_story then
				arg_126_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.35

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1107003031).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 14 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 14)

				if (14 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 14)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1107003032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1107003032
		arg_130_1.duration_ = 8.1

		local var_130_0 = {
			zh = 5.166,
			ja = 8.1
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1107003033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) and arg_130_1.var_.characterEffect1070ui_story == nil then
				arg_130_1.var_.characterEffect1070ui_story = arg_130_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) then
				if arg_130_1.var_.characterEffect1070ui_story and not isNil(arg_130_1.actors_["1070ui_story"]) then
					arg_130_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1070ui_story"]) and arg_130_1.var_.characterEffect1070ui_story then
				arg_130_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_133_2 = 0
			local var_133_3 = 0.65

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(1107003032)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_7 = 26 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 26)

				if (26 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_5) / 26)) > 0 and var_133_3 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003032", "story_v_side_new_1107003.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003032", "story_v_side_new_1107003.awb") / 1000

					if var_133_8 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_2
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_side_new_1107003", "1107003032", "story_v_side_new_1107003.awb")

						arg_130_1:RecordAudio("1107003032", var_133_9)
						arg_130_1:RecordAudio("1107003032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003032", "story_v_side_new_1107003.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003032", "story_v_side_new_1107003.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_10 and arg_130_1.time_ < var_133_2 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1107003033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1107003033
		arg_134_1.duration_ = 12.83

		local var_134_0 = {
			zh = 11.966,
			ja = 12.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1107003034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_137_0 = 0
			local var_137_1 = 1.325

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(1107003033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 53 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 53)

				if (53 <= 0 and var_137_1 or var_137_1 * (utf8.len(var_137_3) / 53)) > 0 and var_137_1 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003033", "story_v_side_new_1107003.awb") ~= 0 then
					local var_137_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003033", "story_v_side_new_1107003.awb") / 1000

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end

					if var_137_2.prefab_name ~= "" and arg_134_1.actors_[var_137_2.prefab_name] ~= nil then
						local var_137_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_2.prefab_name].transform, "story_v_side_new_1107003", "1107003033", "story_v_side_new_1107003.awb")

						arg_134_1:RecordAudio("1107003033", var_137_7)
						arg_134_1:RecordAudio("1107003033", var_137_7)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003033", "story_v_side_new_1107003.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003033", "story_v_side_new_1107003.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1107003034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1107003034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1107003035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) and arg_138_1.var_.characterEffect1070ui_story == nil then
				arg_138_1.var_.characterEffect1070ui_story = arg_138_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) then
				if arg_138_1.var_.characterEffect1070ui_story and not isNil(arg_138_1.actors_["1070ui_story"]) then
					arg_138_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1070ui_story"]) and arg_138_1.var_.characterEffect1070ui_story then
				arg_138_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.3

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(1107003034).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 12 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 12)

				if (12 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 12)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1107003035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1107003035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1107003036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.975

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(1107003035).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 39 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 39)

				if (39 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 39)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1107003036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1107003036
		arg_146_1.duration_ = 7.13

		local var_146_0 = {
			zh = 2.733,
			ja = 7.133
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1107003037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1070ui_story"]) and arg_146_1.var_.characterEffect1070ui_story == nil then
				arg_146_1.var_.characterEffect1070ui_story = arg_146_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1070ui_story"]) then
				if arg_146_1.var_.characterEffect1070ui_story and not isNil(arg_146_1.actors_["1070ui_story"]) then
					arg_146_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1070ui_story"]) and arg_146_1.var_.characterEffect1070ui_story then
				arg_146_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action447")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_149_2 = 0
			local var_149_3 = 0.3

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_2 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_4 = arg_146_1:GetWordFromCfg(1107003036)
				local var_149_5 = arg_146_1:FormatText(var_149_4.content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 12 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 12)

				if (12 <= 0 and var_149_3 or var_149_3 * (utf8.len(var_149_5) / 12)) > 0 and var_149_3 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_2
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003036", "story_v_side_new_1107003.awb") ~= 0 then
					local var_149_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003036", "story_v_side_new_1107003.awb") / 1000

					if var_149_8 + var_149_2 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_2
					end

					if var_149_4.prefab_name ~= "" and arg_146_1.actors_[var_149_4.prefab_name] ~= nil then
						local var_149_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_4.prefab_name].transform, "story_v_side_new_1107003", "1107003036", "story_v_side_new_1107003.awb")

						arg_146_1:RecordAudio("1107003036", var_149_9)
						arg_146_1:RecordAudio("1107003036", var_149_9)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003036", "story_v_side_new_1107003.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003036", "story_v_side_new_1107003.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_3, arg_146_1.talkMaxDuration)

			if var_149_2 <= arg_146_1.time_ and arg_146_1.time_ < var_149_2 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_2) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_2 + var_149_10 and arg_146_1.time_ < var_149_2 + var_149_10 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1107003037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1107003037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1107003038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1070ui_story"]) and arg_150_1.var_.characterEffect1070ui_story == nil then
				arg_150_1.var_.characterEffect1070ui_story = arg_150_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1070ui_story"]) then
				if arg_150_1.var_.characterEffect1070ui_story and not isNil(arg_150_1.actors_["1070ui_story"]) then
					arg_150_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1070ui_story"]) and arg_150_1.var_.characterEffect1070ui_story then
				arg_150_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 0.5

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1107003037).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)

				if (20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1107003038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1107003038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1107003039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.575

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(1107003038).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 23 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 23)

				if (23 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 23)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1107003039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1107003039
		arg_158_1.duration_ = 3.5

		local var_158_0 = {
			zh = 1.999999999999,
			ja = 3.5
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1107003040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1070ui_story"]) and arg_158_1.var_.characterEffect1070ui_story == nil then
				arg_158_1.var_.characterEffect1070ui_story = arg_158_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1070ui_story"]) then
				if arg_158_1.var_.characterEffect1070ui_story and not isNil(arg_158_1.actors_["1070ui_story"]) then
					arg_158_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1070ui_story"]) and arg_158_1.var_.characterEffect1070ui_story then
				arg_158_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action472")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_161_2 = 0
			local var_161_3 = 0.1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_4 = arg_158_1:GetWordFromCfg(1107003039)
				local var_161_5 = arg_158_1:FormatText(var_161_4.content)

				arg_158_1.text_.text = var_161_5

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_7 = 4 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 4)

				if (4 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_5) / 4)) > 0 and var_161_3 < var_161_7 then
					arg_158_1.talkMaxDuration = var_161_7

					if var_161_7 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_5
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003039", "story_v_side_new_1107003.awb") ~= 0 then
					local var_161_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003039", "story_v_side_new_1107003.awb") / 1000

					if var_161_8 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_8 + var_161_2
					end

					if var_161_4.prefab_name ~= "" and arg_158_1.actors_[var_161_4.prefab_name] ~= nil then
						local var_161_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_4.prefab_name].transform, "story_v_side_new_1107003", "1107003039", "story_v_side_new_1107003.awb")

						arg_158_1:RecordAudio("1107003039", var_161_9)
						arg_158_1:RecordAudio("1107003039", var_161_9)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003039", "story_v_side_new_1107003.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003039", "story_v_side_new_1107003.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_10 and arg_158_1.time_ < var_161_2 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1107003040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1107003040
		arg_162_1.duration_ = 3

		local var_162_0 = {
			zh = 2.366,
			ja = 3
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1107003041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_light", "")
			end

			local var_165_1 = 0
			local var_165_2 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(1107003040)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 7 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 7)

				if (7 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 7)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003040", "story_v_side_new_1107003.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003040", "story_v_side_new_1107003.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_side_new_1107003", "1107003040", "story_v_side_new_1107003.awb")

						arg_162_1:RecordAudio("1107003040", var_165_8)
						arg_162_1:RecordAudio("1107003040", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003040", "story_v_side_new_1107003.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003040", "story_v_side_new_1107003.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1107003041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1107003041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1107003042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) and arg_166_1.var_.characterEffect1070ui_story == nil then
				arg_166_1.var_.characterEffect1070ui_story = arg_166_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) then
				if arg_166_1.var_.characterEffect1070ui_story and not isNil(arg_166_1.actors_["1070ui_story"]) then
					arg_166_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1070ui_story"]) and arg_166_1.var_.characterEffect1070ui_story then
				arg_166_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.3

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(1107003041).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 12 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 12)

				if (12 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 12)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1107003042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1107003042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1107003043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0.291666666666667 < arg_170_1.time_ and arg_170_1.time_ <= 0.291666666666667 + arg_173_0 then
				arg_170_1:AudioAction("stop", "effect", "se_story_side_1070", "se_story_1070_light", "")
			end

			local var_173_1 = 0
			local var_173_2 = 0.325

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(1107003042).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)

				if (13 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 13)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1107003043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1107003043
		arg_174_1.duration_ = 7.63

		local var_174_0 = {
			zh = 6.166,
			ja = 7.633
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1107003044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action427")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_0 = arg_174_1.actors_["1070ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1070ui_story == nil then
				arg_174_1.var_.characterEffect1070ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_1 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 and not isNil(var_177_0) then
				if arg_174_1.var_.characterEffect1070ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1070ui_story then
				arg_174_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_177_3 = 0
			local var_177_4 = 0.625

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_5 = arg_174_1:GetWordFromCfg(1107003043)
				local var_177_6 = arg_174_1:FormatText(var_177_5.content)

				arg_174_1.text_.text = var_177_6

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_8 = 25 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_6) / 25)

				if (25 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_6) / 25)) > 0 and var_177_4 < var_177_8 then
					arg_174_1.talkMaxDuration = var_177_8

					if var_177_8 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_3
					end
				end

				arg_174_1.text_.text = var_177_6
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003043", "story_v_side_new_1107003.awb") ~= 0 then
					local var_177_9 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003043", "story_v_side_new_1107003.awb") / 1000

					if var_177_9 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_3
					end

					if var_177_5.prefab_name ~= "" and arg_174_1.actors_[var_177_5.prefab_name] ~= nil then
						local var_177_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_5.prefab_name].transform, "story_v_side_new_1107003", "1107003043", "story_v_side_new_1107003.awb")

						arg_174_1:RecordAudio("1107003043", var_177_10)
						arg_174_1:RecordAudio("1107003043", var_177_10)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003043", "story_v_side_new_1107003.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003043", "story_v_side_new_1107003.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_11 = math.max(var_177_4, arg_174_1.talkMaxDuration)

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_11 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_3) / var_177_11

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_3 + var_177_11 and arg_174_1.time_ < var_177_3 + var_177_11 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1107003044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1107003044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1107003045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1070ui_story = arg_178_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).z)
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles = arg_178_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1070ui_story"].transform.position).z)
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1070ui_story"].transform.localEulerAngles = arg_178_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_181_1 = 0
			local var_181_2 = 0.775

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(1107003044).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 31 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 31)

				if (31 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 31)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play1107003045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1107003045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1107003046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_cave_stream01_loop", "")
			end

			if 0.0666666666666667 < arg_182_1.time_ and arg_182_1.time_ <= 0.0666666666666667 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_cave_drip", "")
			end

			local var_185_2 = 0
			local var_185_3 = 0.6

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_2 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_4 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(1107003045).content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 24 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 24)

				if (24 <= 0 and var_185_3 or var_185_3 * (utf8.len(var_185_4) / 24)) > 0 and var_185_3 < var_185_6 then
					arg_182_1.talkMaxDuration = var_185_6

					if var_185_6 + var_185_2 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_2
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_3, arg_182_1.talkMaxDuration)

			if var_185_2 <= arg_182_1.time_ and arg_182_1.time_ < var_185_2 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_2) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_2 + var_185_7 and arg_182_1.time_ < var_185_2 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1107003046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1107003046
		arg_186_1.duration_ = 5.6

		local var_186_0 = {
			zh = 2.733,
			ja = 5.6
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1107003047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1070ui_story = arg_186_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).z)
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles = arg_186_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_186_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1070ui_story"].transform.position).z)
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1070ui_story"].transform.localEulerAngles = arg_186_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1070ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1070ui_story == nil then
				arg_186_1.var_.characterEffect1070ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1070ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1070ui_story then
				arg_186_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_189_4 = 0
			local var_189_5 = 0.25

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(1107003046)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 10 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 10)

				if (10 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 10)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003046", "story_v_side_new_1107003.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003046", "story_v_side_new_1107003.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_side_new_1107003", "1107003046", "story_v_side_new_1107003.awb")

						arg_186_1:RecordAudio("1107003046", var_189_11)
						arg_186_1:RecordAudio("1107003046", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003046", "story_v_side_new_1107003.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003046", "story_v_side_new_1107003.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1107003047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1107003047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1107003048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1070ui_story"]) and arg_190_1.var_.characterEffect1070ui_story == nil then
				arg_190_1.var_.characterEffect1070ui_story = arg_190_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1070ui_story"]) then
				if arg_190_1.var_.characterEffect1070ui_story and not isNil(arg_190_1.actors_["1070ui_story"]) then
					arg_190_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1070ui_story"]) and arg_190_1.var_.characterEffect1070ui_story then
				arg_190_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.575

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1107003047).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 23 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 23)

				if (23 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 23)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1107003048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1107003048
		arg_194_1.duration_ = 8.3

		local var_194_0 = {
			zh = 7.133,
			ja = 8.3
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1107003049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1070ui_story"]) and arg_194_1.var_.characterEffect1070ui_story == nil then
				arg_194_1.var_.characterEffect1070ui_story = arg_194_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1070ui_story"]) then
				if arg_194_1.var_.characterEffect1070ui_story and not isNil(arg_194_1.actors_["1070ui_story"]) then
					arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1070ui_story"]) and arg_194_1.var_.characterEffect1070ui_story then
				arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_197_2 = 0
			local var_197_3 = 0.575

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(1107003048)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 23 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 23)

				if (23 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 23)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003048", "story_v_side_new_1107003.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003048", "story_v_side_new_1107003.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_side_new_1107003", "1107003048", "story_v_side_new_1107003.awb")

						arg_194_1:RecordAudio("1107003048", var_197_9)
						arg_194_1:RecordAudio("1107003048", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003048", "story_v_side_new_1107003.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003048", "story_v_side_new_1107003.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1107003049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1107003049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1107003050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1070ui_story"]) and arg_198_1.var_.characterEffect1070ui_story == nil then
				arg_198_1.var_.characterEffect1070ui_story = arg_198_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1070ui_story"]) then
				if arg_198_1.var_.characterEffect1070ui_story and not isNil(arg_198_1.actors_["1070ui_story"]) then
					arg_198_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1070ui_story"]) and arg_198_1.var_.characterEffect1070ui_story then
				arg_198_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.925

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1107003049).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 37 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 37)

				if (37 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 37)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1107003050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1107003050
		arg_202_1.duration_ = 3.63

		local var_202_0 = {
			zh = 2.8,
			ja = 3.633
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1107003051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1070ui_story"]) and arg_202_1.var_.characterEffect1070ui_story == nil then
				arg_202_1.var_.characterEffect1070ui_story = arg_202_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1070ui_story"]) then
				if arg_202_1.var_.characterEffect1070ui_story and not isNil(arg_202_1.actors_["1070ui_story"]) then
					arg_202_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1070ui_story"]) and arg_202_1.var_.characterEffect1070ui_story then
				arg_202_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_205_2 = 0
			local var_205_3 = 0.5

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:GetWordFromCfg(1107003050)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 20 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 20)

				if (20 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 20)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003050", "story_v_side_new_1107003.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003050", "story_v_side_new_1107003.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_side_new_1107003", "1107003050", "story_v_side_new_1107003.awb")

						arg_202_1:RecordAudio("1107003050", var_205_9)
						arg_202_1:RecordAudio("1107003050", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003050", "story_v_side_new_1107003.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003050", "story_v_side_new_1107003.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1107003051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1107003051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1107003052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1070ui_story"]) and arg_206_1.var_.characterEffect1070ui_story == nil then
				arg_206_1.var_.characterEffect1070ui_story = arg_206_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1070ui_story"]) then
				if arg_206_1.var_.characterEffect1070ui_story and not isNil(arg_206_1.actors_["1070ui_story"]) then
					arg_206_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1070ui_story"]) and arg_206_1.var_.characterEffect1070ui_story then
				arg_206_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 0.275

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1107003051).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 11 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 11)

				if (11 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 11)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1107003052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1107003052
		arg_210_1.duration_ = 4.83

		local var_210_0 = {
			zh = 4.833,
			ja = 4.733
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1107003053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1070ui_story"]) and arg_210_1.var_.characterEffect1070ui_story == nil then
				arg_210_1.var_.characterEffect1070ui_story = arg_210_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1070ui_story"]) then
				if arg_210_1.var_.characterEffect1070ui_story and not isNil(arg_210_1.actors_["1070ui_story"]) then
					arg_210_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1070ui_story"]) and arg_210_1.var_.characterEffect1070ui_story then
				arg_210_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.575

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(1107003052)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 23 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 23)

				if (23 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 23)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003052", "story_v_side_new_1107003.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003052", "story_v_side_new_1107003.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_side_new_1107003", "1107003052", "story_v_side_new_1107003.awb")

						arg_210_1:RecordAudio("1107003052", var_213_9)
						arg_210_1:RecordAudio("1107003052", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003052", "story_v_side_new_1107003.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003052", "story_v_side_new_1107003.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1107003053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1107003053
		arg_214_1.duration_ = 4.9

		local var_214_0 = {
			zh = 4.4,
			ja = 4.9
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1107003054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1070ui_story = arg_214_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).z)
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles = arg_214_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1070ui_story"].transform.position).z)
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1070ui_story"].transform.localEulerAngles = arg_214_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_217_1 = manager.ui.mainCamera.transform

			if 0.4 < arg_214_1.time_ and arg_214_1.time_ <= 0.4 + arg_217_0 then
				arg_214_1.var_.shakeOldPos = var_217_1.localPosition
			end

			local var_217_2 = 0.6

			if 0.4 <= arg_214_1.time_ and arg_214_1.time_ < 0.4 + var_217_2 then
				local var_217_3, var_217_4 = math.modf((arg_214_1.time_ - 0.4) / 0.066)

				var_217_1.localPosition = Vector3.New(var_217_4 * 0.13, var_217_4 * 0.13, var_217_4 * 0.13) + arg_214_1.var_.shakeOldPos
			end

			if arg_214_1.time_ >= 0.4 + var_217_2 and arg_214_1.time_ < 0.4 + var_217_2 + arg_217_0 then
				var_217_1.localPosition = arg_214_1.var_.shakeOldPos
			end

			local var_217_5 = 0

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.allBtn_.enabled = false
			end

			if arg_214_1.time_ >= var_217_5 + 1 and arg_214_1.time_ < var_217_5 + 1 + arg_217_0 then
				arg_214_1.allBtn_.enabled = true
			end

			local var_217_6 = 0
			local var_217_7 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_2")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_8 = arg_214_1:GetWordFromCfg(1107003053)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 9 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 9)

				if (9 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 9)) > 0 and var_217_7 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003053", "story_v_side_new_1107003.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003053", "story_v_side_new_1107003.awb") / 1000

					if var_217_12 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_6
					end

					if var_217_8.prefab_name ~= "" and arg_214_1.actors_[var_217_8.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_8.prefab_name].transform, "story_v_side_new_1107003", "1107003053", "story_v_side_new_1107003.awb")

						arg_214_1:RecordAudio("1107003053", var_217_13)
						arg_214_1:RecordAudio("1107003053", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003053", "story_v_side_new_1107003.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003053", "story_v_side_new_1107003.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play1107003054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1107003054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1107003055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1070ui_story"]) and arg_218_1.var_.characterEffect1070ui_story == nil then
				arg_218_1.var_.characterEffect1070ui_story = arg_218_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1070ui_story"]) then
				if arg_218_1.var_.characterEffect1070ui_story and not isNil(arg_218_1.actors_["1070ui_story"]) then
					arg_218_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_0)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1070ui_story"]) and arg_218_1.var_.characterEffect1070ui_story then
				arg_218_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_221_1 = 0
			local var_221_2 = 0.3

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1107003054).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 12 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 12)

				if (12 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 12)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1107003055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1107003055
		arg_222_1.duration_ = 10.7

		local var_222_0 = {
			zh = 6.566,
			ja = 10.7
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1107003056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1070ui_story = arg_222_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).z)
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles = arg_222_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_222_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1070ui_story"].transform.position).z)
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1070ui_story"].transform.localEulerAngles = arg_222_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1070ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1070ui_story == nil then
				arg_222_1.var_.characterEffect1070ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1070ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1070ui_story then
				arg_222_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_225_4 = 0
			local var_225_5 = 0.7

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(1107003055)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 28 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 28)

				if (28 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 28)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003055", "story_v_side_new_1107003.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003055", "story_v_side_new_1107003.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_side_new_1107003", "1107003055", "story_v_side_new_1107003.awb")

						arg_222_1:RecordAudio("1107003055", var_225_11)
						arg_222_1:RecordAudio("1107003055", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003055", "story_v_side_new_1107003.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003055", "story_v_side_new_1107003.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1107003056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1107003056
		arg_226_1.duration_ = 10

		local var_226_0 = {
			zh = 7.266,
			ja = 10
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1107003057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_229_0 = 0
			local var_229_1 = 0.9

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(1107003056)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 36 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 36)

				if (36 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 36)) > 0 and var_229_1 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003056", "story_v_side_new_1107003.awb") ~= 0 then
					local var_229_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003056", "story_v_side_new_1107003.awb") / 1000

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end

					if var_229_2.prefab_name ~= "" and arg_226_1.actors_[var_229_2.prefab_name] ~= nil then
						local var_229_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_2.prefab_name].transform, "story_v_side_new_1107003", "1107003056", "story_v_side_new_1107003.awb")

						arg_226_1:RecordAudio("1107003056", var_229_7)
						arg_226_1:RecordAudio("1107003056", var_229_7)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003056", "story_v_side_new_1107003.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003056", "story_v_side_new_1107003.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1107003057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1107003057
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1107003058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) and arg_230_1.var_.characterEffect1070ui_story == nil then
				arg_230_1.var_.characterEffect1070ui_story = arg_230_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) then
				if arg_230_1.var_.characterEffect1070ui_story and not isNil(arg_230_1.actors_["1070ui_story"]) then
					arg_230_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) and arg_230_1.var_.characterEffect1070ui_story then
				arg_230_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.925

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1107003057).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 37 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 37)

				if (37 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 37)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1107003058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1107003058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1107003059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.375

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(1107003058).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 15 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 15)

				if (15 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 15)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1107003059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1107003059
		arg_238_1.duration_ = 10

		local var_238_0 = {
			zh = 9.5,
			ja = 10
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1107003060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) and arg_238_1.var_.characterEffect1070ui_story == nil then
				arg_238_1.var_.characterEffect1070ui_story = arg_238_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) then
				if arg_238_1.var_.characterEffect1070ui_story and not isNil(arg_238_1.actors_["1070ui_story"]) then
					arg_238_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) and arg_238_1.var_.characterEffect1070ui_story then
				arg_238_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_2 = 0
			local var_241_3 = 0.85

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(1107003059)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 34 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 34)

				if (34 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 34)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003059", "story_v_side_new_1107003.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003059", "story_v_side_new_1107003.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_side_new_1107003", "1107003059", "story_v_side_new_1107003.awb")

						arg_238_1:RecordAudio("1107003059", var_241_9)
						arg_238_1:RecordAudio("1107003059", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003059", "story_v_side_new_1107003.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003059", "story_v_side_new_1107003.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1107003060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1107003060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1107003061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) and arg_242_1.var_.characterEffect1070ui_story == nil then
				arg_242_1.var_.characterEffect1070ui_story = arg_242_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) then
				if arg_242_1.var_.characterEffect1070ui_story and not isNil(arg_242_1.actors_["1070ui_story"]) then
					arg_242_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) and arg_242_1.var_.characterEffect1070ui_story then
				arg_242_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.075

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(1107003060).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 3 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 3)

				if (3 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 3)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1107003061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1107003061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1107003062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.425

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1107003061).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 17)

				if (17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 17)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1107003062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1107003062
		arg_250_1.duration_ = 2.3

		local var_250_0 = {
			zh = 1.3,
			ja = 2.3
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1107003063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1070ui_story = arg_250_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).z)
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles = arg_250_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).z)
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles = arg_250_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_253_1 = 0
			local var_253_2 = 0.075

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_2")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(1107003062)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 3 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_4) / 3)

				if (3 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_4) / 3)) > 0 and var_253_2 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003062", "story_v_side_new_1107003.awb") ~= 0 then
					local var_253_7 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003062", "story_v_side_new_1107003.awb") / 1000

					if var_253_7 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_1
					end

					if var_253_3.prefab_name ~= "" and arg_250_1.actors_[var_253_3.prefab_name] ~= nil then
						local var_253_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_3.prefab_name].transform, "story_v_side_new_1107003", "1107003062", "story_v_side_new_1107003.awb")

						arg_250_1:RecordAudio("1107003062", var_253_8)
						arg_250_1:RecordAudio("1107003062", var_253_8)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003062", "story_v_side_new_1107003.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003062", "story_v_side_new_1107003.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_9 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_9 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_9

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_9 and arg_250_1.time_ < var_253_1 + var_253_9 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play1107003063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1107003063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1107003064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1070ui_story"]) and arg_254_1.var_.characterEffect1070ui_story == nil then
				arg_254_1.var_.characterEffect1070ui_story = arg_254_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1070ui_story"]) then
				if arg_254_1.var_.characterEffect1070ui_story and not isNil(arg_254_1.actors_["1070ui_story"]) then
					arg_254_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1070ui_story"]) and arg_254_1.var_.characterEffect1070ui_story then
				arg_254_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_257_1 = 0
			local var_257_2 = 0.1

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_3 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1107003063).content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 4 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 4)

				if (4 <= 0 and var_257_2 or var_257_2 * (utf8.len(var_257_3) / 4)) > 0 and var_257_2 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_1 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_1
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_6 = math.max(var_257_2, arg_254_1.talkMaxDuration)

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_6 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_1) / var_257_6

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_1 + var_257_6 and arg_254_1.time_ < var_257_1 + var_257_6 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1107003064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1107003064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1107003065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.5

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1107003064).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 20 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 20)

				if (20 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 20)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1107003065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1107003065
		arg_262_1.duration_ = 3.6

		local var_262_0 = {
			zh = 1.833,
			ja = 3.6
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1107003066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.15

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_7")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:GetWordFromCfg(1107003065)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 6 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 6)

				if (6 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 6)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003065", "story_v_side_new_1107003.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003065", "story_v_side_new_1107003.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_side_new_1107003", "1107003065", "story_v_side_new_1107003.awb")

						arg_262_1:RecordAudio("1107003065", var_265_6)
						arg_262_1:RecordAudio("1107003065", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003065", "story_v_side_new_1107003.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003065", "story_v_side_new_1107003.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1107003066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1107003066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1107003067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.35

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1107003066).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 14 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 14)

				if (14 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 14)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1107003067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1107003067
		arg_270_1.duration_ = 10.83

		local var_270_0 = {
			zh = 7.9,
			ja = 10.833
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1107003068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1070ui_story = arg_270_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).z)
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles = arg_270_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_270_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1070ui_story"].transform.position).z)
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1070ui_story"].transform.localEulerAngles = arg_270_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1070ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1070ui_story == nil then
				arg_270_1.var_.characterEffect1070ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1070ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1070ui_story then
				arg_270_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_4 = 0
			local var_273_5 = 0.725

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(1107003067)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 29 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 29)

				if (29 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 29)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003067", "story_v_side_new_1107003.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003067", "story_v_side_new_1107003.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_side_new_1107003", "1107003067", "story_v_side_new_1107003.awb")

						arg_270_1:RecordAudio("1107003067", var_273_11)
						arg_270_1:RecordAudio("1107003067", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003067", "story_v_side_new_1107003.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003067", "story_v_side_new_1107003.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1107003068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1107003068
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1107003069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1070ui_story"]) and arg_274_1.var_.characterEffect1070ui_story == nil then
				arg_274_1.var_.characterEffect1070ui_story = arg_274_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1070ui_story"]) then
				if arg_274_1.var_.characterEffect1070ui_story and not isNil(arg_274_1.actors_["1070ui_story"]) then
					arg_274_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1070ui_story"]) and arg_274_1.var_.characterEffect1070ui_story then
				arg_274_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.15

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1107003068).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 6 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 6)

				if (6 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 6)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1107003069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1107003069
		arg_278_1.duration_ = 5.97

		local var_278_0 = {
			zh = 5.966,
			ja = 4.666
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1107003070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1070ui_story = arg_278_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).z)
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles = arg_278_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_278_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1070ui_story"].transform.position).z)
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1070ui_story"].transform.localEulerAngles = arg_278_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1070ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1070ui_story == nil then
				arg_278_1.var_.characterEffect1070ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1070ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1070ui_story then
				arg_278_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_281_4 = 0
			local var_281_5 = 0.5

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(1107003069)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 20 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 20)

				if (20 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 20)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003069", "story_v_side_new_1107003.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003069", "story_v_side_new_1107003.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_side_new_1107003", "1107003069", "story_v_side_new_1107003.awb")

						arg_278_1:RecordAudio("1107003069", var_281_11)
						arg_278_1:RecordAudio("1107003069", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003069", "story_v_side_new_1107003.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003069", "story_v_side_new_1107003.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_12 and arg_278_1.time_ < var_281_4 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1107003070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1107003070
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1107003071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1070ui_story = arg_282_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).z)
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles = arg_282_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1070ui_story"].transform.position).z)
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1070ui_story"].transform.localEulerAngles = arg_282_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_285_1 = manager.ui.mainCamera.transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.shakeOldPos = var_285_1.localPosition
			end

			local var_285_2 = 0.6

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 then
				local var_285_3, var_285_4 = math.modf((arg_282_1.time_ - 0) / 0.066)

				var_285_1.localPosition = Vector3.New(var_285_4 * 0.13, var_285_4 * 0.13, var_285_4 * 0.13) + arg_282_1.var_.shakeOldPos
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 then
				var_285_1.localPosition = arg_282_1.var_.shakeOldPos
			end

			local var_285_5 = 0

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			if arg_282_1.time_ >= var_285_5 + 0.6 and arg_282_1.time_ < var_285_5 + 0.6 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_fall04", "")
			end

			local var_285_7 = 0
			local var_285_8 = 1.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_9 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1107003070).content)

				arg_282_1.text_.text = var_285_9

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 48 <= 0 and var_285_8 or var_285_8 * (utf8.len(var_285_9) / 48)

				if (48 <= 0 and var_285_8 or var_285_8 * (utf8.len(var_285_9) / 48)) > 0 and var_285_8 < var_285_11 then
					arg_282_1.talkMaxDuration = var_285_11

					if var_285_11 + var_285_7 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_7
					end
				end

				arg_282_1.text_.text = var_285_9
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_8, arg_282_1.talkMaxDuration)

			if var_285_7 <= arg_282_1.time_ and arg_282_1.time_ < var_285_7 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_7) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_7 + var_285_12 and arg_282_1.time_ < var_285_7 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1107003071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1107003071
		arg_286_1.duration_ = 6.07

		local var_286_0 = {
			zh = 3.333,
			ja = 6.066
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1107003072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.475

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_9")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:GetWordFromCfg(1107003071)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 19 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 19)

				if (19 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 19)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003071", "story_v_side_new_1107003.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003071", "story_v_side_new_1107003.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_side_new_1107003", "1107003071", "story_v_side_new_1107003.awb")

						arg_286_1:RecordAudio("1107003071", var_289_6)
						arg_286_1:RecordAudio("1107003071", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003071", "story_v_side_new_1107003.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003071", "story_v_side_new_1107003.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1107003072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1107003072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1107003073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1070ui_story"]) and arg_290_1.var_.characterEffect1070ui_story == nil then
				arg_290_1.var_.characterEffect1070ui_story = arg_290_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1070ui_story"]) then
				if arg_290_1.var_.characterEffect1070ui_story and not isNil(arg_290_1.actors_["1070ui_story"]) then
					arg_290_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1070ui_story"]) and arg_290_1.var_.characterEffect1070ui_story then
				arg_290_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.25

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1107003072).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 10 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 10)

				if (10 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 10)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1107003073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1107003073
		arg_294_1.duration_ = 2.23

		local var_294_0 = {
			zh = 1.5,
			ja = 2.233
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1107003074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.05

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_4")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:GetWordFromCfg(1107003073)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 2 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 2)

				if (2 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 2)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003073", "story_v_side_new_1107003.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003073", "story_v_side_new_1107003.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_side_new_1107003", "1107003073", "story_v_side_new_1107003.awb")

						arg_294_1:RecordAudio("1107003073", var_297_6)
						arg_294_1:RecordAudio("1107003073", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003073", "story_v_side_new_1107003.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003073", "story_v_side_new_1107003.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1107003074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1107003074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1107003075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.25

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1107003074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 10 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 10)

				if (10 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 10)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1107003075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1107003075
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1107003076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.325

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(1107003075).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 13 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 13)

				if (13 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 13)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1107003076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1107003076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1107003077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.325

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(1107003076).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 53 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 53)

				if (53 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 53)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1107003077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1107003077
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1107003078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0.85

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(1107003077).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 34 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 34)

				if (34 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 34)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1107003078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1107003078
		arg_314_1.duration_ = 5

		local var_314_0 = {
			zh = 2.633,
			ja = 5
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1107003079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1070ui_story = arg_314_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).z)
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles = arg_314_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_314_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1070ui_story"].transform.position).z)
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1070ui_story"].transform.localEulerAngles = arg_314_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["1070ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1070ui_story == nil then
				arg_314_1.var_.characterEffect1070ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect1070ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1070ui_story then
				arg_314_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_317_4 = 0
			local var_317_5 = 0.5

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_6 = arg_314_1:GetWordFromCfg(1107003078)
				local var_317_7 = arg_314_1:FormatText(var_317_6.content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 20 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 20)

				if (20 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 20)) > 0 and var_317_5 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003078", "story_v_side_new_1107003.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003078", "story_v_side_new_1107003.awb") / 1000

					if var_317_10 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_4
					end

					if var_317_6.prefab_name ~= "" and arg_314_1.actors_[var_317_6.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_6.prefab_name].transform, "story_v_side_new_1107003", "1107003078", "story_v_side_new_1107003.awb")

						arg_314_1:RecordAudio("1107003078", var_317_11)
						arg_314_1:RecordAudio("1107003078", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003078", "story_v_side_new_1107003.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003078", "story_v_side_new_1107003.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_12 and arg_314_1.time_ < var_317_4 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play1107003079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1107003079
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1107003080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1070ui_story"]) and arg_318_1.var_.characterEffect1070ui_story == nil then
				arg_318_1.var_.characterEffect1070ui_story = arg_318_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1070ui_story"]) then
				if arg_318_1.var_.characterEffect1070ui_story and not isNil(arg_318_1.actors_["1070ui_story"]) then
					arg_318_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1070ui_story"]) and arg_318_1.var_.characterEffect1070ui_story then
				arg_318_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_321_1 = 0
			local var_321_2 = 0.075

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(1107003079).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 3 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 3)

				if (3 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 3)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1107003080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1107003080
		arg_322_1.duration_ = 3.47

		local var_322_0 = {
			zh = 3,
			ja = 3.466
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1107003081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1070ui_story"]) and arg_322_1.var_.characterEffect1070ui_story == nil then
				arg_322_1.var_.characterEffect1070ui_story = arg_322_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1070ui_story"]) then
				if arg_322_1.var_.characterEffect1070ui_story and not isNil(arg_322_1.actors_["1070ui_story"]) then
					arg_322_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1070ui_story"]) and arg_322_1.var_.characterEffect1070ui_story then
				arg_322_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_325_2 = 0
			local var_325_3 = 0.25

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:GetWordFromCfg(1107003080)
				local var_325_5 = arg_322_1:FormatText(var_325_4.content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 10 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 10)

				if (10 <= 0 and var_325_3 or var_325_3 * (utf8.len(var_325_5) / 10)) > 0 and var_325_3 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003080", "story_v_side_new_1107003.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003080", "story_v_side_new_1107003.awb") / 1000

					if var_325_8 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_2
					end

					if var_325_4.prefab_name ~= "" and arg_322_1.actors_[var_325_4.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_4.prefab_name].transform, "story_v_side_new_1107003", "1107003080", "story_v_side_new_1107003.awb")

						arg_322_1:RecordAudio("1107003080", var_325_9)
						arg_322_1:RecordAudio("1107003080", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003080", "story_v_side_new_1107003.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003080", "story_v_side_new_1107003.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_10 and arg_322_1.time_ < var_325_2 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1107003081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1107003081
		arg_326_1.duration_ = 7.83

		local var_326_0 = {
			zh = 6.6,
			ja = 7.833
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
				arg_326_0:Play1107003082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_329_0 = 0
			local var_329_1 = 0.8

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(1107003081)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 32 <= 0 and var_329_1 or var_329_1 * (utf8.len(var_329_3) / 32)

				if (32 <= 0 and var_329_1 or var_329_1 * (utf8.len(var_329_3) / 32)) > 0 and var_329_1 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003081", "story_v_side_new_1107003.awb") ~= 0 then
					local var_329_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003081", "story_v_side_new_1107003.awb") / 1000

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end

					if var_329_2.prefab_name ~= "" and arg_326_1.actors_[var_329_2.prefab_name] ~= nil then
						local var_329_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_2.prefab_name].transform, "story_v_side_new_1107003", "1107003081", "story_v_side_new_1107003.awb")

						arg_326_1:RecordAudio("1107003081", var_329_7)
						arg_326_1:RecordAudio("1107003081", var_329_7)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003081", "story_v_side_new_1107003.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003081", "story_v_side_new_1107003.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_8 and arg_326_1.time_ < var_329_0 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1107003082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1107003082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1107003083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1070ui_story"]) and arg_330_1.var_.characterEffect1070ui_story == nil then
				arg_330_1.var_.characterEffect1070ui_story = arg_330_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1070ui_story"]) then
				if arg_330_1.var_.characterEffect1070ui_story and not isNil(arg_330_1.actors_["1070ui_story"]) then
					arg_330_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1070ui_story"]) and arg_330_1.var_.characterEffect1070ui_story then
				arg_330_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.575

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1107003082).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 23 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 23)

				if (23 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 23)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1107003083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1107003083
		arg_334_1.duration_ = 3.27

		local var_334_0 = {
			zh = 3.266,
			ja = 2.333
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1107003084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1070ui_story"]) and arg_334_1.var_.characterEffect1070ui_story == nil then
				arg_334_1.var_.characterEffect1070ui_story = arg_334_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1070ui_story"]) then
				if arg_334_1.var_.characterEffect1070ui_story and not isNil(arg_334_1.actors_["1070ui_story"]) then
					arg_334_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1070ui_story"]) and arg_334_1.var_.characterEffect1070ui_story then
				arg_334_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_337_2 = 0
			local var_337_3 = 0.4

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:GetWordFromCfg(1107003083)
				local var_337_5 = arg_334_1:FormatText(var_337_4.content)

				arg_334_1.text_.text = var_337_5

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_7 = 16 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 16)

				if (16 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_5) / 16)) > 0 and var_337_3 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_5
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003083", "story_v_side_new_1107003.awb") ~= 0 then
					local var_337_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003083", "story_v_side_new_1107003.awb") / 1000

					if var_337_8 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_8 + var_337_2
					end

					if var_337_4.prefab_name ~= "" and arg_334_1.actors_[var_337_4.prefab_name] ~= nil then
						local var_337_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_4.prefab_name].transform, "story_v_side_new_1107003", "1107003083", "story_v_side_new_1107003.awb")

						arg_334_1:RecordAudio("1107003083", var_337_9)
						arg_334_1:RecordAudio("1107003083", var_337_9)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003083", "story_v_side_new_1107003.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003083", "story_v_side_new_1107003.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_10 and arg_334_1.time_ < var_337_2 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1107003084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1107003084
		arg_338_1.duration_ = 9.17

		local var_338_0 = {
			zh = 5.633,
			ja = 9.166
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1107003085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_341_0 = 0
			local var_341_1 = 0.625

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_2 = arg_338_1:GetWordFromCfg(1107003084)
				local var_341_3 = arg_338_1:FormatText(var_341_2.content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 25 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_3) / 25)

				if (25 <= 0 and var_341_1 or var_341_1 * (utf8.len(var_341_3) / 25)) > 0 and var_341_1 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003084", "story_v_side_new_1107003.awb") ~= 0 then
					local var_341_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003084", "story_v_side_new_1107003.awb") / 1000

					if var_341_6 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_6 + var_341_0
					end

					if var_341_2.prefab_name ~= "" and arg_338_1.actors_[var_341_2.prefab_name] ~= nil then
						local var_341_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_2.prefab_name].transform, "story_v_side_new_1107003", "1107003084", "story_v_side_new_1107003.awb")

						arg_338_1:RecordAudio("1107003084", var_341_7)
						arg_338_1:RecordAudio("1107003084", var_341_7)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003084", "story_v_side_new_1107003.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003084", "story_v_side_new_1107003.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_8 and arg_338_1.time_ < var_341_0 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1107003085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1107003085
		arg_342_1.duration_ = 9.4

		local var_342_0 = {
			zh = 9.4,
			ja = 3.766
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
				arg_342_0:Play1107003086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_345_0 = 0
			local var_345_1 = 1.025

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(1107003085)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 41 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 41)

				if (41 <= 0 and var_345_1 or var_345_1 * (utf8.len(var_345_3) / 41)) > 0 and var_345_1 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003085", "story_v_side_new_1107003.awb") ~= 0 then
					local var_345_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003085", "story_v_side_new_1107003.awb") / 1000

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end

					if var_345_2.prefab_name ~= "" and arg_342_1.actors_[var_345_2.prefab_name] ~= nil then
						local var_345_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_2.prefab_name].transform, "story_v_side_new_1107003", "1107003085", "story_v_side_new_1107003.awb")

						arg_342_1:RecordAudio("1107003085", var_345_7)
						arg_342_1:RecordAudio("1107003085", var_345_7)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003085", "story_v_side_new_1107003.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003085", "story_v_side_new_1107003.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_8 and arg_342_1.time_ < var_345_0 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1107003086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1107003086
		arg_346_1.duration_ = 7.3

		local var_346_0 = {
			zh = 7.3,
			ja = 7
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
				arg_346_0:Play1107003087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_349_0 = 0
			local var_349_1 = 0.75

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_2 = arg_346_1:GetWordFromCfg(1107003086)
				local var_349_3 = arg_346_1:FormatText(var_349_2.content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 30 <= 0 and var_349_1 or var_349_1 * (utf8.len(var_349_3) / 30)

				if (30 <= 0 and var_349_1 or var_349_1 * (utf8.len(var_349_3) / 30)) > 0 and var_349_1 < var_349_5 then
					arg_346_1.talkMaxDuration = var_349_5

					if var_349_5 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003086", "story_v_side_new_1107003.awb") ~= 0 then
					local var_349_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003086", "story_v_side_new_1107003.awb") / 1000

					if var_349_6 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_6 + var_349_0
					end

					if var_349_2.prefab_name ~= "" and arg_346_1.actors_[var_349_2.prefab_name] ~= nil then
						local var_349_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_2.prefab_name].transform, "story_v_side_new_1107003", "1107003086", "story_v_side_new_1107003.awb")

						arg_346_1:RecordAudio("1107003086", var_349_7)
						arg_346_1:RecordAudio("1107003086", var_349_7)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003086", "story_v_side_new_1107003.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003086", "story_v_side_new_1107003.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_8 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_8 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_8

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_8 and arg_346_1.time_ < var_349_0 + var_349_8 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1107003087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1107003087
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1107003088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1070ui_story = arg_350_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).z)
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles = arg_350_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_350_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1070ui_story"].transform.position).z)
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1070ui_story"].transform.localEulerAngles = arg_350_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_353_1 = 0
			local var_353_2 = 0.3

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
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

				local var_353_3 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1107003087).content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 12 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 12)

				if (12 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 12)) > 0 and var_353_2 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_6 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_6 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_6

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_6 and arg_350_1.time_ < var_353_1 + var_353_6 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1107003088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1107003088
		arg_354_1.duration_ = 9.83

		local var_354_0 = {
			zh = 4.866,
			ja = 9.833
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
				arg_354_0:Play1107003089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1070ui_story"]) and arg_354_1.var_.characterEffect1070ui_story == nil then
				arg_354_1.var_.characterEffect1070ui_story = arg_354_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1070ui_story"]) then
				if arg_354_1.var_.characterEffect1070ui_story and not isNil(arg_354_1.actors_["1070ui_story"]) then
					arg_354_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1070ui_story"]) and arg_354_1.var_.characterEffect1070ui_story then
				arg_354_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_357_2 = arg_354_1.actors_["1070ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1070ui_story = var_357_2.localPosition
			end

			local var_357_3 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_3 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_354_1.time_ - 0) / var_357_3)
				var_357_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_2.position).x, (manager.ui.mainCamera.transform.position - var_357_2.position).y, (manager.ui.mainCamera.transform.position - var_357_2.position).z)
				var_357_2.localEulerAngles.z = 0
				var_357_2.localEulerAngles.x = 0
				var_357_2.localEulerAngles = var_357_2.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_3 and arg_354_1.time_ < 0 + var_357_3 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_357_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_2.position).x, (manager.ui.mainCamera.transform.position - var_357_2.position).y, (manager.ui.mainCamera.transform.position - var_357_2.position).z)
				var_357_2.localEulerAngles.z = 0
				var_357_2.localEulerAngles.x = 0
				var_357_2.localEulerAngles = var_357_2.localEulerAngles
			end

			local var_357_4 = 0
			local var_357_5 = 0.425

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(1107003088)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 17 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 17)

				if (17 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 17)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003088", "story_v_side_new_1107003.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003088", "story_v_side_new_1107003.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_side_new_1107003", "1107003088", "story_v_side_new_1107003.awb")

						arg_354_1:RecordAudio("1107003088", var_357_11)
						arg_354_1:RecordAudio("1107003088", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003088", "story_v_side_new_1107003.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003088", "story_v_side_new_1107003.awb")
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1107003089 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1107003089
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1107003090(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1070ui_story"]) and arg_358_1.var_.characterEffect1070ui_story == nil then
				arg_358_1.var_.characterEffect1070ui_story = arg_358_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1070ui_story"]) then
				if arg_358_1.var_.characterEffect1070ui_story and not isNil(arg_358_1.actors_["1070ui_story"]) then
					arg_358_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1070ui_story"]) and arg_358_1.var_.characterEffect1070ui_story then
				arg_358_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 0.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(1107003089).content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 8 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 8)

				if (8 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 8)) > 0 and var_361_2 < var_361_5 then
					arg_358_1.talkMaxDuration = var_361_5

					if var_361_5 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_6 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_6 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_6

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_6 and arg_358_1.time_ < var_361_1 + var_361_6 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1107003090 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1107003090
		arg_362_1.duration_ = 2.83

		local var_362_0 = {
			zh = 2.333,
			ja = 2.833
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
				arg_362_0:Play1107003091(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1070ui_story"]) and arg_362_1.var_.characterEffect1070ui_story == nil then
				arg_362_1.var_.characterEffect1070ui_story = arg_362_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1070ui_story"]) then
				if arg_362_1.var_.characterEffect1070ui_story and not isNil(arg_362_1.actors_["1070ui_story"]) then
					arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1070ui_story"]) and arg_362_1.var_.characterEffect1070ui_story then
				arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_365_2 = 0
			local var_365_3 = 0.075

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_4 = arg_362_1:GetWordFromCfg(1107003090)
				local var_365_5 = arg_362_1:FormatText(var_365_4.content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 3 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 3)

				if (3 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 3)) > 0 and var_365_3 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003090", "story_v_side_new_1107003.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003090", "story_v_side_new_1107003.awb") / 1000

					if var_365_8 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_2
					end

					if var_365_4.prefab_name ~= "" and arg_362_1.actors_[var_365_4.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_4.prefab_name].transform, "story_v_side_new_1107003", "1107003090", "story_v_side_new_1107003.awb")

						arg_362_1:RecordAudio("1107003090", var_365_9)
						arg_362_1:RecordAudio("1107003090", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003090", "story_v_side_new_1107003.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003090", "story_v_side_new_1107003.awb")
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
	Play1107003091 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1107003091
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1107003092(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1070ui_story"]) and arg_366_1.var_.characterEffect1070ui_story == nil then
				arg_366_1.var_.characterEffect1070ui_story = arg_366_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1070ui_story"]) then
				if arg_366_1.var_.characterEffect1070ui_story and not isNil(arg_366_1.actors_["1070ui_story"]) then
					arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_0)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1070ui_story"]) and arg_366_1.var_.characterEffect1070ui_story then
				arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_369_1 = 0
			local var_369_2 = 0.175

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_3 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1107003091).content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 7 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 7)

				if (7 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 7)) > 0 and var_369_2 < var_369_5 then
					arg_366_1.talkMaxDuration = var_369_5

					if var_369_5 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_6 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_6 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_6

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_6 and arg_366_1.time_ < var_369_1 + var_369_6 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1107003092 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1107003092
		arg_370_1.duration_ = 6.03

		local var_370_0 = {
			zh = 3.133,
			ja = 6.033
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
				arg_370_0:Play1107003093(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1070ui_story = arg_370_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_373_0 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 then
				arg_370_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_370_1.time_ - 0) / var_373_0)
				arg_370_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).z)
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles = arg_370_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 then
				arg_370_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_370_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_370_1.actors_["1070ui_story"].transform.position).z)
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_370_1.actors_["1070ui_story"].transform.localEulerAngles = arg_370_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_373_1 = arg_370_1.actors_["1070ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1070ui_story == nil then
				arg_370_1.var_.characterEffect1070ui_story = var_373_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_2 and not isNil(var_373_1) then
				if arg_370_1.var_.characterEffect1070ui_story and not isNil(var_373_1) then
					arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_2 and arg_370_1.time_ < 0 + var_373_2 + arg_373_0 and not isNil(var_373_1) and arg_370_1.var_.characterEffect1070ui_story then
				arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_373_4 = 0
			local var_373_5 = 0.325

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(1107003092)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 13 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 13)

				if (13 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 13)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003092", "story_v_side_new_1107003.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003092", "story_v_side_new_1107003.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_side_new_1107003", "1107003092", "story_v_side_new_1107003.awb")

						arg_370_1:RecordAudio("1107003092", var_373_11)
						arg_370_1:RecordAudio("1107003092", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003092", "story_v_side_new_1107003.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003092", "story_v_side_new_1107003.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play1107003093 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1107003093
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1107003094(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["1070ui_story"]) and arg_374_1.var_.characterEffect1070ui_story == nil then
				arg_374_1.var_.characterEffect1070ui_story = arg_374_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["1070ui_story"]) then
				if arg_374_1.var_.characterEffect1070ui_story and not isNil(arg_374_1.actors_["1070ui_story"]) then
					arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_0)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["1070ui_story"]) and arg_374_1.var_.characterEffect1070ui_story then
				arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_377_1 = 0
			local var_377_2 = 0.6

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_3 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(1107003093).content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 24 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 24)

				if (24 <= 0 and var_377_2 or var_377_2 * (utf8.len(var_377_3) / 24)) > 0 and var_377_2 < var_377_5 then
					arg_374_1.talkMaxDuration = var_377_5

					if var_377_5 + var_377_1 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + var_377_1
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_6 = math.max(var_377_2, arg_374_1.talkMaxDuration)

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_6 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_1) / var_377_6

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_1 + var_377_6 and arg_374_1.time_ < var_377_1 + var_377_6 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1107003094 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1107003094
		arg_378_1.duration_ = 9.2

		local var_378_0 = {
			zh = 6.666,
			ja = 9.2
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
				arg_378_0:Play1107003095(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1070ui_story"]) and arg_378_1.var_.characterEffect1070ui_story == nil then
				arg_378_1.var_.characterEffect1070ui_story = arg_378_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1070ui_story"]) then
				if arg_378_1.var_.characterEffect1070ui_story and not isNil(arg_378_1.actors_["1070ui_story"]) then
					arg_378_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1070ui_story"]) and arg_378_1.var_.characterEffect1070ui_story then
				arg_378_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_381_2 = 0
			local var_381_3 = 0.675

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_4 = arg_378_1:GetWordFromCfg(1107003094)
				local var_381_5 = arg_378_1:FormatText(var_381_4.content)

				arg_378_1.text_.text = var_381_5

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 27 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 27)

				if (27 <= 0 and var_381_3 or var_381_3 * (utf8.len(var_381_5) / 27)) > 0 and var_381_3 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_5
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003094", "story_v_side_new_1107003.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003094", "story_v_side_new_1107003.awb") / 1000

					if var_381_8 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_2
					end

					if var_381_4.prefab_name ~= "" and arg_378_1.actors_[var_381_4.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_4.prefab_name].transform, "story_v_side_new_1107003", "1107003094", "story_v_side_new_1107003.awb")

						arg_378_1:RecordAudio("1107003094", var_381_9)
						arg_378_1:RecordAudio("1107003094", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003094", "story_v_side_new_1107003.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003094", "story_v_side_new_1107003.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_10 and arg_378_1.time_ < var_381_2 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1107003095 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1107003095
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1107003096(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) and arg_382_1.var_.characterEffect1070ui_story == nil then
				arg_382_1.var_.characterEffect1070ui_story = arg_382_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) then
				if arg_382_1.var_.characterEffect1070ui_story and not isNil(arg_382_1.actors_["1070ui_story"]) then
					arg_382_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) and arg_382_1.var_.characterEffect1070ui_story then
				arg_382_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.6

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1107003095).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 24 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 24)

				if (24 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 24)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1107003096 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1107003096
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1107003097(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.575

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
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

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(1107003096).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 23 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 23)

				if (23 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 23)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1107003097 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1107003097
		arg_390_1.duration_ = 2

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1107003098(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) and arg_390_1.var_.characterEffect1070ui_story == nil then
				arg_390_1.var_.characterEffect1070ui_story = arg_390_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.2

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) then
				if arg_390_1.var_.characterEffect1070ui_story and not isNil(arg_390_1.actors_["1070ui_story"]) then
					arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) and arg_390_1.var_.characterEffect1070ui_story then
				arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_393_2 = 0
			local var_393_3 = 0.075

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_4 = arg_390_1:GetWordFromCfg(1107003097)
				local var_393_5 = arg_390_1:FormatText(var_393_4.content)

				arg_390_1.text_.text = var_393_5

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_7 = 3 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 3)

				if (3 <= 0 and var_393_3 or var_393_3 * (utf8.len(var_393_5) / 3)) > 0 and var_393_3 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_2
					end
				end

				arg_390_1.text_.text = var_393_5
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003097", "story_v_side_new_1107003.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003097", "story_v_side_new_1107003.awb") / 1000

					if var_393_8 + var_393_2 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_2
					end

					if var_393_4.prefab_name ~= "" and arg_390_1.actors_[var_393_4.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_4.prefab_name].transform, "story_v_side_new_1107003", "1107003097", "story_v_side_new_1107003.awb")

						arg_390_1:RecordAudio("1107003097", var_393_9)
						arg_390_1:RecordAudio("1107003097", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003097", "story_v_side_new_1107003.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003097", "story_v_side_new_1107003.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_3, arg_390_1.talkMaxDuration)

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_2) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_2 + var_393_10 and arg_390_1.time_ < var_393_2 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1107003098 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1107003098
		arg_394_1.duration_ = 2.77

		local var_394_0 = {
			zh = 2.766,
			ja = 2.366
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1107003099(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_397_0 = 0
			local var_397_1 = 0.225

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(1107003098)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 9 <= 0 and var_397_1 or var_397_1 * (utf8.len(var_397_3) / 9)

				if (9 <= 0 and var_397_1 or var_397_1 * (utf8.len(var_397_3) / 9)) > 0 and var_397_1 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003098", "story_v_side_new_1107003.awb") ~= 0 then
					local var_397_6 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003098", "story_v_side_new_1107003.awb") / 1000

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end

					if var_397_2.prefab_name ~= "" and arg_394_1.actors_[var_397_2.prefab_name] ~= nil then
						local var_397_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_2.prefab_name].transform, "story_v_side_new_1107003", "1107003098", "story_v_side_new_1107003.awb")

						arg_394_1:RecordAudio("1107003098", var_397_7)
						arg_394_1:RecordAudio("1107003098", var_397_7)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003098", "story_v_side_new_1107003.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003098", "story_v_side_new_1107003.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_8 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_8 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_8

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_8 and arg_394_1.time_ < var_397_0 + var_397_8 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1107003099 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1107003099
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1107003100(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(arg_398_1.actors_["1070ui_story"]) and arg_398_1.var_.characterEffect1070ui_story == nil then
				arg_398_1.var_.characterEffect1070ui_story = arg_398_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_0 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 and not isNil(arg_398_1.actors_["1070ui_story"]) then
				if arg_398_1.var_.characterEffect1070ui_story and not isNil(arg_398_1.actors_["1070ui_story"]) then
					arg_398_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_398_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_398_1.time_ - 0) / var_401_0)
				end
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 and not isNil(arg_398_1.actors_["1070ui_story"]) and arg_398_1.var_.characterEffect1070ui_story then
				arg_398_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_398_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_401_1 = 0
			local var_401_2 = 0.325

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(1107003099).content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 13 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 13)

				if (13 <= 0 and var_401_2 or var_401_2 * (utf8.len(var_401_3) / 13)) > 0 and var_401_2 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_1 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_1
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_6 = math.max(var_401_2, arg_398_1.talkMaxDuration)

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_6 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_1) / var_401_6

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_1 + var_401_6 and arg_398_1.time_ < var_401_1 + var_401_6 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1107003100 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1107003100
		arg_402_1.duration_ = 2

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1107003101(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1070ui_story"]) and arg_402_1.var_.characterEffect1070ui_story == nil then
				arg_402_1.var_.characterEffect1070ui_story = arg_402_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1070ui_story"]) then
				if arg_402_1.var_.characterEffect1070ui_story and not isNil(arg_402_1.actors_["1070ui_story"]) then
					arg_402_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1070ui_story"]) and arg_402_1.var_.characterEffect1070ui_story then
				arg_402_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:AudioAction("play", "effect", "se_story_side_1070", "se_story_1070_airship01", "")
			end

			local var_405_3 = 0
			local var_405_4 = 0.05

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_3 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_5 = arg_402_1:GetWordFromCfg(1107003100)
				local var_405_6 = arg_402_1:FormatText(var_405_5.content)

				arg_402_1.text_.text = var_405_6

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_8 = 2 <= 0 and var_405_4 or var_405_4 * (utf8.len(var_405_6) / 2)

				if (2 <= 0 and var_405_4 or var_405_4 * (utf8.len(var_405_6) / 2)) > 0 and var_405_4 < var_405_8 then
					arg_402_1.talkMaxDuration = var_405_8

					if var_405_8 + var_405_3 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_3
					end
				end

				arg_402_1.text_.text = var_405_6
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003100", "story_v_side_new_1107003.awb") ~= 0 then
					local var_405_9 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003100", "story_v_side_new_1107003.awb") / 1000

					if var_405_9 + var_405_3 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_9 + var_405_3
					end

					if var_405_5.prefab_name ~= "" and arg_402_1.actors_[var_405_5.prefab_name] ~= nil then
						local var_405_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_5.prefab_name].transform, "story_v_side_new_1107003", "1107003100", "story_v_side_new_1107003.awb")

						arg_402_1:RecordAudio("1107003100", var_405_10)
						arg_402_1:RecordAudio("1107003100", var_405_10)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003100", "story_v_side_new_1107003.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003100", "story_v_side_new_1107003.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_11 = math.max(var_405_4, arg_402_1.talkMaxDuration)

			if var_405_3 <= arg_402_1.time_ and arg_402_1.time_ < var_405_3 + var_405_11 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_3) / var_405_11

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_3 + var_405_11 and arg_402_1.time_ < var_405_3 + var_405_11 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1107003101 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1107003101
		arg_406_1.duration_ = 3.23

		local var_406_0 = {
			zh = 3,
			ja = 3.233
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1107003102(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.275

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_1 = arg_406_1:GetWordFromCfg(1107003101)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 11 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 11)

				if (11 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 11)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003101", "story_v_side_new_1107003.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003101", "story_v_side_new_1107003.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_side_new_1107003", "1107003101", "story_v_side_new_1107003.awb")

						arg_406_1:RecordAudio("1107003101", var_409_6)
						arg_406_1:RecordAudio("1107003101", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003101", "story_v_side_new_1107003.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003101", "story_v_side_new_1107003.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1107003102 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1107003102
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1107003103(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1070ui_story"]) and arg_410_1.var_.characterEffect1070ui_story == nil then
				arg_410_1.var_.characterEffect1070ui_story = arg_410_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1070ui_story"]) then
				if arg_410_1.var_.characterEffect1070ui_story and not isNil(arg_410_1.actors_["1070ui_story"]) then
					arg_410_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1070ui_story"]) and arg_410_1.var_.characterEffect1070ui_story then
				arg_410_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.05

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1107003102).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 2 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 2)

				if (2 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 2)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1107003103 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1107003103
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1107003104(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.225

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(1107003103).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 9 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 9)

				if (9 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 9)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play1107003104 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1107003104
		arg_418_1.duration_ = 4.37

		local var_418_0 = {
			zh = 1.999999999999,
			ja = 4.366
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
			arg_418_1.auto_ = false
		end

		function arg_418_1.playNext_(arg_420_0)
			arg_418_1.onStoryFinished_()
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1070ui_story"]) and arg_418_1.var_.characterEffect1070ui_story == nil then
				arg_418_1.var_.characterEffect1070ui_story = arg_418_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1070ui_story"]) then
				if arg_418_1.var_.characterEffect1070ui_story and not isNil(arg_418_1.actors_["1070ui_story"]) then
					arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1070ui_story"]) and arg_418_1.var_.characterEffect1070ui_story then
				arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_421_2 = 0
			local var_421_3 = 0.15

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(1107003104)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 6 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 6)

				if (6 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 6)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003104", "story_v_side_new_1107003.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_side_new_1107003", "1107003104", "story_v_side_new_1107003.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_side_new_1107003", "1107003104", "story_v_side_new_1107003.awb")

						arg_418_1:RecordAudio("1107003104", var_421_9)
						arg_418_1:RecordAudio("1107003104", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_new_1107003", "1107003104", "story_v_side_new_1107003.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_new_1107003", "1107003104", "story_v_side_new_1107003.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST44"
	},
	voices = {
		"story_v_side_new_1107003.awb"
	}
}
