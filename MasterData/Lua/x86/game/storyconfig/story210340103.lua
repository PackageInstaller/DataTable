return {
	Play1103403001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103403001
		arg_1_1.duration_ = 4.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103403002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11o == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_4_0.name = "I11o"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11o = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11o

				arg_1_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11o" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1034ui_story"

			if arg_1_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1034ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_1_1.time_ - 0) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, 100, 0)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1034ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_1_1.time_ - 2) / var_4_16)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -0.93, -6)
				var_4_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_15.position).x, (manager.ui.mainCamera.transform.position - var_4_15.position).y, (manager.ui.mainCamera.transform.position - var_4_15.position).z)
				var_4_15.localEulerAngles.z = 0
				var_4_15.localEulerAngles.x = 0
				var_4_15.localEulerAngles = var_4_15.localEulerAngles
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 2
			local var_4_25 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_27 = arg_1_1:GetWordFromCfg(1103403001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 2 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 2)

				if (2 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 2)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")

						arg_1_1:RecordAudio("1103403001", var_4_32)
						arg_1_1:RecordAudio("1103403001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403001", "story_v_side_new_1103403.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1103403002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103403002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103403003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_12_0 = arg_9_1.actors_["1034ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1034ui_story == nil then
				arg_9_1.var_.characterEffect1034ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_1 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 and not isNil(var_12_0) then
				if arg_9_1.var_.characterEffect1034ui_story and not isNil(var_12_0) then
					arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_1)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1034ui_story then
				arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_12_2 = 0
			local var_12_3 = 1.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1103403002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 55 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 55)

				if (55 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 55)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1103403003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103403003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103403004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			if 1 < arg_13_1.time_ and arg_13_1.time_ <= 1 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_side_1034", "se_story_side_1034_clap", "")
			end

			local var_16_1 = 0
			local var_16_2 = 0.75

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1103403003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 30 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 30)

				if (30 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 30)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1103403004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103403004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1103403005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_20_0 = 0
			local var_20_1 = 0.4

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_2 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1103403004).content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 16 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_2) / 16)

				if (16 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_2) / 16)) > 0 and var_20_1 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_5 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_5 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_5

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_5 and arg_17_1.time_ < var_20_0 + var_20_5 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1103403005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103403005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103403006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_24_0 = 0
			local var_24_1 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_2 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1103403005).content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 20 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 20)

				if (20 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 20)) > 0 and var_24_1 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_5 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_5 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_5

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_5 and arg_21_1.time_ < var_24_0 + var_24_5 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1103403006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1103403006
		arg_25_1.duration_ = 5.5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1103403007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1034ui_story"]) and arg_25_1.var_.characterEffect1034ui_story == nil then
				arg_25_1.var_.characterEffect1034ui_story = arg_25_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1034ui_story"]) then
				if arg_25_1.var_.characterEffect1034ui_story and not isNil(arg_25_1.actors_["1034ui_story"]) then
					arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1034ui_story"]) and arg_25_1.var_.characterEffect1034ui_story then
				arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.775

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(1103403006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 31)

				if (31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 31)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")

						arg_25_1:RecordAudio("1103403006", var_28_9)
						arg_25_1:RecordAudio("1103403006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403006", "story_v_side_new_1103403.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1103403007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1103403007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1103403008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story == nil then
				arg_29_1.var_.characterEffect1034ui_story = arg_29_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) then
				if arg_29_1.var_.characterEffect1034ui_story and not isNil(arg_29_1.actors_["1034ui_story"]) then
					arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1034ui_story"]) and arg_29_1.var_.characterEffect1034ui_story then
				arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_32_1 = 0
			local var_32_2 = 0.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1103403007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 17)

				if (17 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 17)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1103403008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1103403008
		arg_33_1.duration_ = 4.5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1103403009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = arg_33_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) then
				if arg_33_1.var_.characterEffect1034ui_story and not isNil(arg_33_1.actors_["1034ui_story"]) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1034ui_story"]) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_36_2 = 0
			local var_36_3 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(1103403008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)

				if (19 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 19)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")

						arg_33_1:RecordAudio("1103403008", var_36_9)
						arg_33_1:RecordAudio("1103403008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403008", "story_v_side_new_1103403.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1103403009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1103403009
		arg_37_1.duration_ = 8.3

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1103403010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_40_0 = 0
			local var_40_1 = 0.925

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(1103403009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 37 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 37)

				if (37 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 37)) > 0 and var_40_1 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb") ~= 0 then
					local var_40_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb") / 1000

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end

					if var_40_2.prefab_name ~= "" and arg_37_1.actors_[var_40_2.prefab_name] ~= nil then
						local var_40_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_2.prefab_name].transform, "story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")

						arg_37_1:RecordAudio("1103403009", var_40_7)
						arg_37_1:RecordAudio("1103403009", var_40_7)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403009", "story_v_side_new_1103403.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1103403010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1103403010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1103403011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story == nil then
				arg_41_1.var_.characterEffect1034ui_story = arg_41_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) then
				if arg_41_1.var_.characterEffect1034ui_story and not isNil(arg_41_1.actors_["1034ui_story"]) then
					arg_41_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story then
				arg_41_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_44_1 = 0
			local var_44_2 = 0.175

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1103403010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 7 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 7)

				if (7 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 7)) > 0 and var_44_2 < var_44_5 then
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
	Play1103403011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1103403011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1103403012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_0 = 0
			local var_48_1 = 0.675

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_2 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1103403011).content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 27 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_2) / 27)

				if (27 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_2) / 27)) > 0 and var_48_1 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_5 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_5 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_5

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_5 and arg_45_1.time_ < var_48_0 + var_48_5 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1103403012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1103403012
		arg_49_1.duration_ = 4.9

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1103403013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1034ui_story"]) and arg_49_1.var_.characterEffect1034ui_story == nil then
				arg_49_1.var_.characterEffect1034ui_story = arg_49_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1034ui_story"]) then
				if arg_49_1.var_.characterEffect1034ui_story and not isNil(arg_49_1.actors_["1034ui_story"]) then
					arg_49_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1034ui_story"]) and arg_49_1.var_.characterEffect1034ui_story then
				arg_49_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_52_2 = 0
			local var_52_3 = 0.675

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(1103403012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 27 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 27)

				if (27 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 27)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")

						arg_49_1:RecordAudio("1103403012", var_52_9)
						arg_49_1:RecordAudio("1103403012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403012", "story_v_side_new_1103403.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1103403013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1103403013
		arg_53_1.duration_ = 6.77

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1103403014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.7

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(1103403013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 28 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 28)

				if (28 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 28)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")

						arg_53_1:RecordAudio("1103403013", var_56_6)
						arg_53_1:RecordAudio("1103403013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403013", "story_v_side_new_1103403.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1103403014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1103403014
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"

			SetActive(arg_57_1.choicesGo_, true)

			for iter_58_0, iter_58_1 in ipairs(arg_57_1.choices_) do
				SetActive(iter_58_1.go, iter_58_0 <= 2)
			end

			arg_57_1.choices_[1].txt.text = arg_57_1:FormatText(StoryChoiceCfg[1455].name)
			arg_57_1.choices_[2].txt.text = arg_57_1:FormatText(StoryChoiceCfg[1456].name)
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1103403015(arg_57_1)
			end

			if arg_59_0 == 2 then
				arg_57_0:Play1103403018(arg_57_1)
			end

			arg_57_1:RecordChoiceLog(1103403014, 1455, 1456)
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story == nil then
				arg_57_1.var_.characterEffect1034ui_story = arg_57_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) then
				if arg_57_1.var_.characterEffect1034ui_story and not isNil(arg_57_1.actors_["1034ui_story"]) then
					arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story then
				arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1103403015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1103403015
		arg_61_1.duration_ = 4.4

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1103403016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) and arg_61_1.var_.characterEffect1034ui_story == nil then
				arg_61_1.var_.characterEffect1034ui_story = arg_61_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) then
				if arg_61_1.var_.characterEffect1034ui_story and not isNil(arg_61_1.actors_["1034ui_story"]) then
					arg_61_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1034ui_story"]) and arg_61_1.var_.characterEffect1034ui_story then
				arg_61_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_64_2 = 0
			local var_64_3 = 0.375

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(1103403015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 15 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 15)

				if (15 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 15)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")

						arg_61_1:RecordAudio("1103403015", var_64_9)
						arg_61_1:RecordAudio("1103403015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403015", "story_v_side_new_1103403.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1103403016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1103403016
		arg_65_1.duration_ = 3.87

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1103403017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_68_0 = 0
			local var_68_1 = 0.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(1103403016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 17 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 17)

				if (17 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 17)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")

						arg_65_1:RecordAudio("1103403016", var_68_7)
						arg_65_1:RecordAudio("1103403016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403016", "story_v_side_new_1103403.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1103403017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1103403017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1103403020(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) and arg_69_1.var_.characterEffect1034ui_story == nil then
				arg_69_1.var_.characterEffect1034ui_story = arg_69_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) then
				if arg_69_1.var_.characterEffect1034ui_story and not isNil(arg_69_1.actors_["1034ui_story"]) then
					arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1034ui_story"]) and arg_69_1.var_.characterEffect1034ui_story then
				arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1103403017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 14 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 14)

				if (14 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 14)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1103403020 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1103403020
		arg_73_1.duration_ = 4.37

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1103403021(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) and arg_73_1.var_.characterEffect1034ui_story == nil then
				arg_73_1.var_.characterEffect1034ui_story = arg_73_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) then
				if arg_73_1.var_.characterEffect1034ui_story and not isNil(arg_73_1.actors_["1034ui_story"]) then
					arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1034ui_story"]) and arg_73_1.var_.characterEffect1034ui_story then
				arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1103403020)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 26 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 26)

				if (26 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 26)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")

						arg_73_1:RecordAudio("1103403020", var_76_9)
						arg_73_1:RecordAudio("1103403020", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403020", "story_v_side_new_1103403.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1103403021 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1103403021
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1103403022(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1034ui_story"]) and arg_77_1.var_.characterEffect1034ui_story == nil then
				arg_77_1.var_.characterEffect1034ui_story = arg_77_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1034ui_story"]) then
				if arg_77_1.var_.characterEffect1034ui_story and not isNil(arg_77_1.actors_["1034ui_story"]) then
					arg_77_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1034ui_story"]) and arg_77_1.var_.characterEffect1034ui_story then
				arg_77_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1103403021).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 15 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 15)

				if (15 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 15)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1103403022 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1103403022
		arg_81_1.duration_ = 3.5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1103403023(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) and arg_81_1.var_.characterEffect1034ui_story == nil then
				arg_81_1.var_.characterEffect1034ui_story = arg_81_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) then
				if arg_81_1.var_.characterEffect1034ui_story and not isNil(arg_81_1.actors_["1034ui_story"]) then
					arg_81_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1034ui_story"]) and arg_81_1.var_.characterEffect1034ui_story then
				arg_81_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action472")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_84_2 = 0
			local var_84_3 = 0.225

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(1103403022)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 9 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 9)

				if (9 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 9)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")

						arg_81_1:RecordAudio("1103403022", var_84_9)
						arg_81_1:RecordAudio("1103403022", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403022", "story_v_side_new_1103403.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1103403023 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1103403023
		arg_85_1.duration_ = 6.37

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1103403024(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action425")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_88_0 = 0
			local var_88_1 = 0.533333333333333

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(1103403023)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 32 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 32)

				if (32 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 32)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")

						arg_85_1:RecordAudio("1103403023", var_88_7)
						arg_85_1:RecordAudio("1103403023", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403023", "story_v_side_new_1103403.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1103403024 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1103403024
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1103403025(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1034ui_story"]) and arg_89_1.var_.characterEffect1034ui_story == nil then
				arg_89_1.var_.characterEffect1034ui_story = arg_89_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1034ui_story"]) then
				if arg_89_1.var_.characterEffect1034ui_story and not isNil(arg_89_1.actors_["1034ui_story"]) then
					arg_89_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1034ui_story"]) and arg_89_1.var_.characterEffect1034ui_story then
				arg_89_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_92_1 = 0
			local var_92_2 = 0.35

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1103403024).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 14 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 14)

				if (14 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 14)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1103403025 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1103403025
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1103403026(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_0 = 0
			local var_96_1 = 0.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_2 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1103403025).content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_2) / 25)

				if (25 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_2) / 25)) > 0 and var_96_1 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_5 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_5 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_5

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_5 and arg_93_1.time_ < var_96_0 + var_96_5 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1103403026 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1103403026
		arg_97_1.duration_ = 7.3

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1103403027(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1034ui_story"]) and arg_97_1.var_.characterEffect1034ui_story == nil then
				arg_97_1.var_.characterEffect1034ui_story = arg_97_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1034ui_story"]) then
				if arg_97_1.var_.characterEffect1034ui_story and not isNil(arg_97_1.actors_["1034ui_story"]) then
					arg_97_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1034ui_story"]) and arg_97_1.var_.characterEffect1034ui_story then
				arg_97_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_100_2 = 0
			local var_100_3 = 1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(1103403026)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 40 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 40)

				if (40 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 40)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")

						arg_97_1:RecordAudio("1103403026", var_100_9)
						arg_97_1:RecordAudio("1103403026", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403026", "story_v_side_new_1103403.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1103403027 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1103403027
		arg_101_1.duration_ = 7.33

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1103403028(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_104_0 = 0
			local var_104_1 = 0.9

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(1103403027)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 36 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 36)

				if (36 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 36)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")

						arg_101_1:RecordAudio("1103403027", var_104_7)
						arg_101_1:RecordAudio("1103403027", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403027", "story_v_side_new_1103403.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1103403028 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1103403028
		arg_105_1.duration_ = 3.87

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1103403029(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_108_0 = 0
			local var_108_1 = 0.5

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(1103403028)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 20 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 20)

				if (20 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 20)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")

						arg_105_1:RecordAudio("1103403028", var_108_7)
						arg_105_1:RecordAudio("1103403028", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403028", "story_v_side_new_1103403.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1103403029 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1103403029
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1103403030(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1034ui_story"]) and arg_109_1.var_.characterEffect1034ui_story == nil then
				arg_109_1.var_.characterEffect1034ui_story = arg_109_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1034ui_story"]) then
				if arg_109_1.var_.characterEffect1034ui_story and not isNil(arg_109_1.actors_["1034ui_story"]) then
					arg_109_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1034ui_story"]) and arg_109_1.var_.characterEffect1034ui_story then
				arg_109_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.7

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1103403029).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 28 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 28)

				if (28 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 28)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1103403030 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1103403030
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1103403031(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.7

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1103403030).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 28 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 28)

				if (28 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 28)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1103403031 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1103403031
		arg_117_1.duration_ = 1.27

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1103403032(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1034ui_story"]) and arg_117_1.var_.characterEffect1034ui_story == nil then
				arg_117_1.var_.characterEffect1034ui_story = arg_117_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1034ui_story"]) then
				if arg_117_1.var_.characterEffect1034ui_story and not isNil(arg_117_1.actors_["1034ui_story"]) then
					arg_117_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1034ui_story"]) and arg_117_1.var_.characterEffect1034ui_story then
				arg_117_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_120_2 = 0
			local var_120_3 = 0.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(1103403031)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 4 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 4)

				if (4 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 4)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")

						arg_117_1:RecordAudio("1103403031", var_120_9)
						arg_117_1:RecordAudio("1103403031", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403031", "story_v_side_new_1103403.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1103403032 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1103403032
		arg_121_1.duration_ = 6.67

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1103403033(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 1.66666666666667 < arg_121_1.time_ and arg_121_1.time_ <= 1.66666666666667 + arg_124_0 and not isNil(arg_121_1.actors_["1034ui_story"]) and arg_121_1.var_.characterEffect1034ui_story == nil then
				arg_121_1.var_.characterEffect1034ui_story = arg_121_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 1.66666666666667 <= arg_121_1.time_ and arg_121_1.time_ < 1.66666666666667 + var_124_0 and not isNil(arg_121_1.actors_["1034ui_story"]) then
				if arg_121_1.var_.characterEffect1034ui_story and not isNil(arg_121_1.actors_["1034ui_story"]) then
					arg_121_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.66666666666667) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 1.66666666666667 + var_124_0 and arg_121_1.time_ < 1.66666666666667 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1034ui_story"]) and arg_121_1.var_.characterEffect1034ui_story then
				arg_121_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_124_1 = 1.66666666666667

			if 1.66666666666667 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = false

				arg_121_1:SetGaussion(false)
			end

			local var_124_2 = 0.333333333333333

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = Color.New(1, 1, 1)

				var_124_3.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_1) / var_124_2)
				arg_121_1.mask_.color = var_124_3
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				local var_124_4 = Color.New(1, 1, 1)

				arg_121_1.mask_.enabled = false
				var_124_4.a = 0
				arg_121_1.mask_.color = var_124_4
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				local var_124_5 = arg_121_1.bgs_.I11o

				arg_121_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_6 = var_124_5:GetComponent("SpriteRenderer")

				if var_124_6 and var_124_6.sprite then
					local var_124_7 = 2 * (var_124_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_5.transform.localScale = Vector3.New(var_124_7 / var_124_6.sprite.bounds.size.y < var_124_7 * manager.ui.mainCameraCom_.aspect / var_124_6.sprite.bounds.size.x and var_124_7 * manager.ui.mainCameraCom_.aspect / var_124_6.sprite.bounds.size.x or var_124_7 / var_124_6.sprite.bounds.size.y, var_124_7 / var_124_6.sprite.bounds.size.y < var_124_7 * manager.ui.mainCameraCom_.aspect / var_124_6.sprite.bounds.size.x and var_124_7 * manager.ui.mainCameraCom_.aspect / var_124_6.sprite.bounds.size.x or var_124_7 / var_124_6.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "I11o" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.66666666666667 < arg_121_1.time_ and arg_121_1.time_ <= 1.66666666666667 + arg_124_0 then
				arg_121_1:AudioAction("play", "effect", "se_story_16", "se_story_16_camera", "")
			end

			local var_124_9 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			if arg_121_1.time_ >= var_124_9 + 2.66666666666667 and arg_121_1.time_ < var_124_9 + 2.66666666666667 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_10 = 1.66666666666667
			local var_124_11 = 0.975

			if 1.66666666666667 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_12 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1103403032).content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_14 = 39 <= 0 and var_124_11 or var_124_11 * (utf8.len(var_124_12) / 39)

				if (39 <= 0 and var_124_11 or var_124_11 * (utf8.len(var_124_12) / 39)) > 0 and var_124_11 < var_124_14 then
					arg_121_1.talkMaxDuration = var_124_14

					if var_124_14 + var_124_10 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_10
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_15 = math.max(var_124_11, arg_121_1.talkMaxDuration)

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_10) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_10 + var_124_15 and arg_121_1.time_ < var_124_10 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1103403033 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1103403033
		arg_125_1.duration_ = 4.63

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1103403034(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1034ui_story"]) and arg_125_1.var_.characterEffect1034ui_story == nil then
				arg_125_1.var_.characterEffect1034ui_story = arg_125_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1034ui_story"]) then
				if arg_125_1.var_.characterEffect1034ui_story and not isNil(arg_125_1.actors_["1034ui_story"]) then
					arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1034ui_story"]) and arg_125_1.var_.characterEffect1034ui_story then
				arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_128_2 = arg_125_1.actors_["1034ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1034ui_story = var_128_2.localPosition
			end

			local var_128_3 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_125_1.time_ - 0) / var_128_3)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(0, -0.93, -6)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			local var_128_4 = 0
			local var_128_5 = 0.6

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1103403033)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 24 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 24)

				if (24 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 24)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")

						arg_125_1:RecordAudio("1103403033", var_128_11)
						arg_125_1:RecordAudio("1103403033", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403033", "story_v_side_new_1103403.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1103403034 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1103403034
		arg_129_1.duration_ = 6.27

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1103403035(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_132_0 = 0
			local var_132_1 = 0.775

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(1103403034)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 31 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 31)

				if (31 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 31)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")

						arg_129_1:RecordAudio("1103403034", var_132_7)
						arg_129_1:RecordAudio("1103403034", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403034", "story_v_side_new_1103403.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1103403035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1103403035
		arg_133_1.duration_ = 4.97

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1103403036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_136_0 = 0
			local var_136_1 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(1103403035)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 26 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 26)

				if (26 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 26)) > 0 and var_136_1 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb") ~= 0 then
					local var_136_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb") / 1000

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end

					if var_136_2.prefab_name ~= "" and arg_133_1.actors_[var_136_2.prefab_name] ~= nil then
						local var_136_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_2.prefab_name].transform, "story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")

						arg_133_1:RecordAudio("1103403035", var_136_7)
						arg_133_1:RecordAudio("1103403035", var_136_7)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403035", "story_v_side_new_1103403.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1103403036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1103403036
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1103403037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1034ui_story"]) and arg_137_1.var_.characterEffect1034ui_story == nil then
				arg_137_1.var_.characterEffect1034ui_story = arg_137_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1034ui_story"]) then
				if arg_137_1.var_.characterEffect1034ui_story and not isNil(arg_137_1.actors_["1034ui_story"]) then
					arg_137_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1034ui_story"]) and arg_137_1.var_.characterEffect1034ui_story then
				arg_137_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.475

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1103403036).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 19 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 19)

				if (19 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 19)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1103403037 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1103403037
		arg_141_1.duration_ = 7.27

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1103403038(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) and arg_141_1.var_.characterEffect1034ui_story == nil then
				arg_141_1.var_.characterEffect1034ui_story = arg_141_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) then
				if arg_141_1.var_.characterEffect1034ui_story and not isNil(arg_141_1.actors_["1034ui_story"]) then
					arg_141_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) and arg_141_1.var_.characterEffect1034ui_story then
				arg_141_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_2 = 0
			local var_144_3 = 0.7

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(1103403037)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 28 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 28)

				if (28 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 28)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")

						arg_141_1:RecordAudio("1103403037", var_144_9)
						arg_141_1:RecordAudio("1103403037", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403037", "story_v_side_new_1103403.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1103403038 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1103403038
		arg_145_1.duration_ = 6.67

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1103403039(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_148_0 = 0
			local var_148_1 = 0.7

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(1103403038)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 28 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 28)

				if (28 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 28)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")

						arg_145_1:RecordAudio("1103403038", var_148_7)
						arg_145_1:RecordAudio("1103403038", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403038", "story_v_side_new_1103403.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1103403039 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1103403039
		arg_149_1.duration_ = 8.43

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1103403040(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_152_0 = 0
			local var_152_1 = 0.925

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(1103403039)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 37 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 37)

				if (37 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 37)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")

						arg_149_1:RecordAudio("1103403039", var_152_7)
						arg_149_1:RecordAudio("1103403039", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403039", "story_v_side_new_1103403.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1103403040 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1103403040
		arg_153_1.duration_ = 6.57

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1103403041(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.7

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(1103403040)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 28)

				if (28 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 28)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")

						arg_153_1:RecordAudio("1103403040", var_156_6)
						arg_153_1:RecordAudio("1103403040", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403040", "story_v_side_new_1103403.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1103403041 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1103403041
		arg_157_1.duration_ = 4.33

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1103403042(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_160_0 = 0
			local var_160_1 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(1103403041)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 20 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 20)

				if (20 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 20)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")

						arg_157_1:RecordAudio("1103403041", var_160_7)
						arg_157_1:RecordAudio("1103403041", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403041", "story_v_side_new_1103403.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1103403042 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1103403042
		arg_161_1.duration_ = 2

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1103403043(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1034ui_story"]) and arg_161_1.var_.characterEffect1034ui_story == nil then
				arg_161_1.var_.characterEffect1034ui_story = arg_161_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1034ui_story"]) then
				if arg_161_1.var_.characterEffect1034ui_story and not isNil(arg_161_1.actors_["1034ui_story"]) then
					arg_161_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1034ui_story"]) and arg_161_1.var_.characterEffect1034ui_story then
				arg_161_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_164_2 = 0
			local var_164_3 = 0.05

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_4 = arg_161_1:GetWordFromCfg(1103403042)
				local var_164_5 = arg_161_1:FormatText(var_164_4.content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 2 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 2)

				if (2 <= 0 and var_164_3 or var_164_3 * (utf8.len(var_164_5) / 2)) > 0 and var_164_3 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb") / 1000

					if var_164_8 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_2
					end

					if var_164_4.prefab_name ~= "" and arg_161_1.actors_[var_164_4.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_4.prefab_name].transform, "story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")

						arg_161_1:RecordAudio("1103403042", var_164_9)
						arg_161_1:RecordAudio("1103403042", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403042", "story_v_side_new_1103403.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_10 and arg_161_1.time_ < var_164_2 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1103403043 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1103403043
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1103403044(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_0 = arg_165_1.actors_["1034ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1034ui_story == nil then
				arg_165_1.var_.characterEffect1034ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_1 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 and not isNil(var_168_0) then
				if arg_165_1.var_.characterEffect1034ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_1)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1034ui_story then
				arg_165_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_168_2 = 0
			local var_168_3 = 1.15

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1103403043).content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 46 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 46)

				if (46 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_4) / 46)) > 0 and var_168_3 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_7 and arg_165_1.time_ < var_168_2 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1103403044 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1103403044
		arg_169_1.duration_ = 5.17

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1103403045(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1034ui_story"]) and arg_169_1.var_.characterEffect1034ui_story == nil then
				arg_169_1.var_.characterEffect1034ui_story = arg_169_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1034ui_story"]) then
				if arg_169_1.var_.characterEffect1034ui_story and not isNil(arg_169_1.actors_["1034ui_story"]) then
					arg_169_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1034ui_story"]) and arg_169_1.var_.characterEffect1034ui_story then
				arg_169_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_172_2 = 0
			local var_172_3 = 0.8

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(1103403044)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 32 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 32)

				if (32 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 32)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")

						arg_169_1:RecordAudio("1103403044", var_172_9)
						arg_169_1:RecordAudio("1103403044", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403044", "story_v_side_new_1103403.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1103403045 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1103403045
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1103403046(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1034ui_story"]) and arg_173_1.var_.characterEffect1034ui_story == nil then
				arg_173_1.var_.characterEffect1034ui_story = arg_173_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1034ui_story"]) then
				if arg_173_1.var_.characterEffect1034ui_story and not isNil(arg_173_1.actors_["1034ui_story"]) then
					arg_173_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1034ui_story"]) and arg_173_1.var_.characterEffect1034ui_story then
				arg_173_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1103403045).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 10 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 10)

				if (10 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 10)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1103403046 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1103403046
		arg_177_1.duration_ = 2.27

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1103403047(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1034ui_story"]) and arg_177_1.var_.characterEffect1034ui_story == nil then
				arg_177_1.var_.characterEffect1034ui_story = arg_177_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1034ui_story"]) then
				if arg_177_1.var_.characterEffect1034ui_story and not isNil(arg_177_1.actors_["1034ui_story"]) then
					arg_177_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1034ui_story"]) and arg_177_1.var_.characterEffect1034ui_story then
				arg_177_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_180_2 = 0
			local var_180_3 = 0.225

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(1103403046)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 9 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 9)

				if (9 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 9)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")

						arg_177_1:RecordAudio("1103403046", var_180_9)
						arg_177_1:RecordAudio("1103403046", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403046", "story_v_side_new_1103403.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1103403047 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1103403047
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1103403048(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1034ui_story"]) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = arg_181_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1034ui_story"]) then
				if arg_181_1.var_.characterEffect1034ui_story and not isNil(arg_181_1.actors_["1034ui_story"]) then
					arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1034ui_story"]) and arg_181_1.var_.characterEffect1034ui_story then
				arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_184_1 = arg_181_1.actors_["1034ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1034ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1034ui_story then
				arg_181_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_184_3 = 0
			local var_184_4 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_5 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1103403047).content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 18 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 18)

				if (18 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 18)) > 0 and var_184_4 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_8 and arg_181_1.time_ < var_184_3 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1103403048 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1103403048
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1103403049(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.55

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1103403048).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 22 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 22)

				if (22 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 22)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1103403049 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1103403049
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1103403050(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_192_0 = 0
			local var_192_1 = 0.5

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_2 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(1103403049).content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 20 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 20)

				if (20 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 20)) > 0 and var_192_1 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_5 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_5 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_5

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_5 and arg_189_1.time_ < var_192_0 + var_192_5 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1103403050 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1103403050
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1103403051(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0.466666666666667 < arg_193_1.time_ and arg_193_1.time_ <= 0.466666666666667 + arg_196_0 then
				arg_193_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0.466666666666667 < arg_193_1.time_ and arg_193_1.time_ <= 0.466666666666667 + arg_196_0 then
				arg_193_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_196_0 = 0
			local var_196_1 = 0.925

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1103403050).content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 37 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_2) / 37)

				if (37 <= 0 and var_196_1 or var_196_1 * (utf8.len(var_196_2) / 37)) > 0 and var_196_1 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_5 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_5 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_5

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_5 and arg_193_1.time_ < var_196_0 + var_196_5 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1103403051 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1103403051
		arg_197_1.duration_ = 2.3

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1103403052(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1034ui_story"]) and arg_197_1.var_.characterEffect1034ui_story == nil then
				arg_197_1.var_.characterEffect1034ui_story = arg_197_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1034ui_story"]) then
				if arg_197_1.var_.characterEffect1034ui_story and not isNil(arg_197_1.actors_["1034ui_story"]) then
					arg_197_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1034ui_story"]) and arg_197_1.var_.characterEffect1034ui_story then
				arg_197_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_200_2 = 0
			local var_200_3 = 0.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(1103403051)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 13 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 13)

				if (13 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 13)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")

						arg_197_1:RecordAudio("1103403051", var_200_9)
						arg_197_1:RecordAudio("1103403051", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403051", "story_v_side_new_1103403.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1103403052 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1103403052
		arg_201_1.duration_ = 4.37

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1103403053(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_204_0 = 0
			local var_204_1 = 0.45

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(1103403052)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 18 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 18)

				if (18 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 18)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb") ~= 0 then
					local var_204_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb") / 1000

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end

					if var_204_2.prefab_name ~= "" and arg_201_1.actors_[var_204_2.prefab_name] ~= nil then
						local var_204_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_2.prefab_name].transform, "story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")

						arg_201_1:RecordAudio("1103403052", var_204_7)
						arg_201_1:RecordAudio("1103403052", var_204_7)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403052", "story_v_side_new_1103403.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_8 and arg_201_1.time_ < var_204_0 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1103403053 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1103403053
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1103403054(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1034ui_story"]) and arg_205_1.var_.characterEffect1034ui_story == nil then
				arg_205_1.var_.characterEffect1034ui_story = arg_205_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1034ui_story"]) then
				if arg_205_1.var_.characterEffect1034ui_story and not isNil(arg_205_1.actors_["1034ui_story"]) then
					arg_205_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1034ui_story"]) and arg_205_1.var_.characterEffect1034ui_story then
				arg_205_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.125

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1103403053).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 5 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 5)

				if (5 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 5)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1103403054 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1103403054
		arg_209_1.duration_ = 3.03

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1103403055(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1034ui_story"]) and arg_209_1.var_.characterEffect1034ui_story == nil then
				arg_209_1.var_.characterEffect1034ui_story = arg_209_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1034ui_story"]) then
				if arg_209_1.var_.characterEffect1034ui_story and not isNil(arg_209_1.actors_["1034ui_story"]) then
					arg_209_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1034ui_story"]) and arg_209_1.var_.characterEffect1034ui_story then
				arg_209_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_212_2 = 0
			local var_212_3 = 0.375

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(1103403054)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 15 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 15)

				if (15 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 15)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")

						arg_209_1:RecordAudio("1103403054", var_212_9)
						arg_209_1:RecordAudio("1103403054", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403054", "story_v_side_new_1103403.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1103403055 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1103403055
		arg_213_1.duration_ = 5.2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1103403056(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_0 = 0
			local var_216_1 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(1103403055)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 27 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 27)

				if (27 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 27)) > 0 and var_216_1 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb") ~= 0 then
					local var_216_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb") / 1000

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end

					if var_216_2.prefab_name ~= "" and arg_213_1.actors_[var_216_2.prefab_name] ~= nil then
						local var_216_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_2.prefab_name].transform, "story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")

						arg_213_1:RecordAudio("1103403055", var_216_7)
						arg_213_1:RecordAudio("1103403055", var_216_7)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403055", "story_v_side_new_1103403.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1103403056 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1103403056
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"

			SetActive(arg_217_1.choicesGo_, true)

			for iter_218_0, iter_218_1 in ipairs(arg_217_1.choices_) do
				SetActive(iter_218_1.go, iter_218_0 <= 2)
			end

			arg_217_1.choices_[1].txt.text = arg_217_1:FormatText(StoryChoiceCfg[1457].name)
			arg_217_1.choices_[2].txt.text = arg_217_1:FormatText(StoryChoiceCfg[1458].name)
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1103403057(arg_217_1)
			end

			if arg_219_0 == 2 then
				arg_217_0:Play1103403060(arg_217_1)
			end

			arg_217_1:RecordChoiceLog(1103403056, 1457, 1458)
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1034ui_story"]) and arg_217_1.var_.characterEffect1034ui_story == nil then
				arg_217_1.var_.characterEffect1034ui_story = arg_217_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.366666666666667

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1034ui_story"]) then
				if arg_217_1.var_.characterEffect1034ui_story and not isNil(arg_217_1.actors_["1034ui_story"]) then
					arg_217_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1034ui_story"]) and arg_217_1.var_.characterEffect1034ui_story then
				arg_217_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_1 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_1 + 2 and arg_217_1.time_ < var_220_1 + 2 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1103403057 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1103403057
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1103403058(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_0 = 0
			local var_224_1 = 0.625

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_2 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1103403057).content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 25 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_2) / 25)

				if (25 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_2) / 25)) > 0 and var_224_1 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_5 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_5 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_5

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_5 and arg_221_1.time_ < var_224_0 + var_224_5 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1103403058 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1103403058
		arg_225_1.duration_ = 6.43

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1103403059(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1034ui_story"]) and arg_225_1.var_.characterEffect1034ui_story == nil then
				arg_225_1.var_.characterEffect1034ui_story = arg_225_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1034ui_story"]) then
				if arg_225_1.var_.characterEffect1034ui_story and not isNil(arg_225_1.actors_["1034ui_story"]) then
					arg_225_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1034ui_story"]) and arg_225_1.var_.characterEffect1034ui_story then
				arg_225_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_228_2 = 0
			local var_228_3 = 0.6

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(1103403058)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 24 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 24)

				if (24 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 24)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")

						arg_225_1:RecordAudio("1103403058", var_228_9)
						arg_225_1:RecordAudio("1103403058", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403058", "story_v_side_new_1103403.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1103403059 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1103403059
		arg_229_1.duration_ = 4

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1103403064(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_0 = 0
			local var_232_1 = 0.575

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(1103403059)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 23 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 23)

				if (23 <= 0 and var_232_1 or var_232_1 * (utf8.len(var_232_3) / 23)) > 0 and var_232_1 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb") ~= 0 then
					local var_232_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb") / 1000

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end

					if var_232_2.prefab_name ~= "" and arg_229_1.actors_[var_232_2.prefab_name] ~= nil then
						local var_232_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_2.prefab_name].transform, "story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")

						arg_229_1:RecordAudio("1103403059", var_232_7)
						arg_229_1:RecordAudio("1103403059", var_232_7)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403059", "story_v_side_new_1103403.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1103403064 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1103403064
		arg_233_1.duration_ = 1.33

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1103403065(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1034ui_story"]) and arg_233_1.var_.characterEffect1034ui_story == nil then
				arg_233_1.var_.characterEffect1034ui_story = arg_233_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1034ui_story"]) then
				if arg_233_1.var_.characterEffect1034ui_story and not isNil(arg_233_1.actors_["1034ui_story"]) then
					arg_233_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1034ui_story"]) and arg_233_1.var_.characterEffect1034ui_story then
				arg_233_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_236_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_3 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_3

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_3
						arg_233_1.bgmTxt2_.text = var_236_3
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle01", "")
			end

			local var_236_5 = 0
			local var_236_6 = 0.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[171].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_7 = arg_233_1:GetWordFromCfg(1103403064)
				local var_236_8 = arg_233_1:FormatText(var_236_7.content)

				arg_233_1.text_.text = var_236_8

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_10 = 4 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 4)

				if (4 <= 0 and var_236_6 or var_236_6 * (utf8.len(var_236_8) / 4)) > 0 and var_236_6 < var_236_10 then
					arg_233_1.talkMaxDuration = var_236_10

					if var_236_10 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_5
					end
				end

				arg_233_1.text_.text = var_236_8
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb") ~= 0 then
					local var_236_11 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb") / 1000

					if var_236_11 + var_236_5 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_5
					end

					if var_236_7.prefab_name ~= "" and arg_233_1.actors_[var_236_7.prefab_name] ~= nil then
						local var_236_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_7.prefab_name].transform, "story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")

						arg_233_1:RecordAudio("1103403064", var_236_12)
						arg_233_1:RecordAudio("1103403064", var_236_12)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403064", "story_v_side_new_1103403.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_13 = math.max(var_236_6, arg_233_1.talkMaxDuration)

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_13 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_5) / var_236_13

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_5 + var_236_13 and arg_233_1.time_ < var_236_5 + var_236_13 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1103403065 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1103403065
		arg_238_1.duration_ = 7.8

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1103403066(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_9000

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= 2 + arg_241_0 then
				local var_241_0 = arg_238_1.bgs_.I11o

				arg_238_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_1 = var_241_0:GetComponent("SpriteRenderer")

				if var_241_1 and var_241_1.sprite then
					local var_241_2 = 2 * (var_241_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_0.transform.localScale = Vector3.New(var_241_2 / var_241_1.sprite.bounds.size.y < var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x and var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x or var_241_2 / var_241_1.sprite.bounds.size.y, var_241_2 / var_241_1.sprite.bounds.size.y < var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x and var_241_2 * manager.ui.mainCameraCom_.aspect / var_241_1.sprite.bounds.size.x or var_241_2 / var_241_1.sprite.bounds.size.y, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "I11o" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_3 = 2.8

			if 2.8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			if arg_238_1.time_ >= var_241_3 + 0.3 and arg_238_1.time_ < var_241_3 + 0.3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_4 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_5 = 2

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_5 then
				local var_241_6 = Color.New(0, 0, 0)

				var_241_6.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_4) / var_241_5)
				arg_238_1.mask_.color = var_241_6
			end

			if arg_238_1.time_ >= var_241_4 + var_241_5 and arg_238_1.time_ < var_241_4 + var_241_5 + arg_241_0 then
				local var_241_7 = Color.New(0, 0, 0)

				var_241_7.a = 1
				arg_238_1.mask_.color = var_241_7
			end

			local var_241_8 = 2

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_9 = 0.8

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_9 then
				local var_241_10 = Color.New(0, 0, 0)

				var_241_10.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_8) / var_241_9)
				arg_238_1.mask_.color = var_241_10
			end

			if arg_238_1.time_ >= var_241_8 + var_241_9 and arg_238_1.time_ < var_241_8 + var_241_9 + arg_241_0 then
				local var_241_11 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_11.a = 0
				arg_238_1.mask_.color = var_241_11
			end

			local var_241_12 = arg_238_1.actors_["1034ui_story"].transform

			if 1.98333333333333 < arg_238_1.time_ and arg_238_1.time_ <= 1.98333333333333 + arg_241_0 then
				arg_238_1.var_.moveOldPos1034ui_story = var_241_12.localPosition
			end

			local var_241_13 = 0.001

			if 1.98333333333333 <= arg_238_1.time_ and arg_238_1.time_ < 1.98333333333333 + var_241_13 then
				var_241_12.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.98333333333333) / var_241_13)
				var_241_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_12.position).x, (manager.ui.mainCamera.transform.position - var_241_12.position).y, (manager.ui.mainCamera.transform.position - var_241_12.position).z)
				var_241_12.localEulerAngles.z = 0
				var_241_12.localEulerAngles.x = 0
				var_241_12.localEulerAngles = var_241_12.localEulerAngles
			end

			if arg_238_1.time_ >= 1.98333333333333 + var_241_13 and arg_238_1.time_ < 1.98333333333333 + var_241_13 + arg_241_0 then
				var_241_12.localPosition = Vector3.New(0, 100, 0)
				var_241_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_12.position).x, (manager.ui.mainCamera.transform.position - var_241_12.position).y, (manager.ui.mainCamera.transform.position - var_241_12.position).z)
				var_241_12.localEulerAngles.z = 0
				var_241_12.localEulerAngles.x = 0
				var_241_12.localEulerAngles = var_241_12.localEulerAngles
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= 2 + arg_241_0 then
				local var_241_14 = arg_238_1.var_.effectwqerweqqwetewrgwe

				if not arg_238_1.var_.effectwqerweqqwetewrgwe then
					var_241_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_241_14.name = "wqerweqqwetewrgwe"
					arg_238_1.var_.effectwqerweqqwetewrgwe = var_241_14
				else
					var_241_14.transform:SetParent(var_241_9000)
				end

				var_241_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_241_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_241_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_241_17 = var_241_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_241_2, iter_241_3 in ipairs((var_241_17:ToTable())) do
					iter_241_3.transform.localScale = Vector3.New(iter_241_3.transform.localScale.x / var_241_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_241_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_241_3.transform.localScale.y / var_241_16, iter_241_3.transform.localScale.z)
				end
			end

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= 2 + arg_241_0 then
				arg_238_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle04", "")
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_20 = 2.8
			local var_241_21 = 1.075

			if 2.8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_20 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_22 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_22:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_23 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1103403065).content)

				arg_238_1.text_.text = var_241_23

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_25 = 43 <= 0 and var_241_21 or var_241_21 * (utf8.len(var_241_23) / 43)

				if (43 <= 0 and var_241_21 or var_241_21 * (utf8.len(var_241_23) / 43)) > 0 and var_241_21 < var_241_25 then
					arg_238_1.talkMaxDuration = var_241_25
					var_241_20 = var_241_20 + 0.3

					if var_241_25 + var_241_20 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_25 + var_241_20
					end
				end

				arg_238_1.text_.text = var_241_23
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_26 = var_241_20 + 0.3
			local var_241_27 = math.max(var_241_21, arg_238_1.talkMaxDuration)

			if var_241_20 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_26 + var_241_27 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_26) / var_241_27

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_26 + var_241_27 and arg_238_1.time_ < var_241_26 + var_241_27 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1103403066 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1103403066
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1103403067(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				local var_247_0 = arg_244_1.var_.effectweqrwerqwerqwerqwe

				if not arg_244_1.var_.effectweqrwerqwerqwerqwe then
					var_247_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), goTrans)
					var_247_0.name = ""
					arg_244_1.var_.effectweqrwerqwerqwerqwe = var_247_0
				else
					var_247_0.transform:SetParent(goTrans)
				end

				var_247_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_247_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_247_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_247_3 = var_247_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_247_0, iter_247_1 in ipairs((var_247_3:ToTable())) do
					iter_247_1.transform.localScale = Vector3.New(iter_247_1.transform.localScale.x / var_247_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_247_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_247_1.transform.localScale.y / var_247_2, iter_247_1.transform.localScale.z)
				end
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_247_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_7 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_7

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_7
						arg_244_1.bgmTxt2_.text = var_247_7
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_244_1.time_ and arg_244_1.time_ <= 0.4 + arg_247_0 then
				arg_244_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_247_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_10 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_10

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_10
						arg_244_1.bgmTxt2_.text = var_247_10
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_247_11 = 0
			local var_247_12 = 1.3

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_13 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1103403066).content)

				arg_244_1.text_.text = var_247_13

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_15 = 52 <= 0 and var_247_12 or var_247_12 * (utf8.len(var_247_13) / 52)

				if (52 <= 0 and var_247_12 or var_247_12 * (utf8.len(var_247_13) / 52)) > 0 and var_247_12 < var_247_15 then
					arg_244_1.talkMaxDuration = var_247_15

					if var_247_15 + var_247_11 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_15 + var_247_11
					end
				end

				arg_244_1.text_.text = var_247_13
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_12, arg_244_1.talkMaxDuration)

			if var_247_11 <= arg_244_1.time_ and arg_244_1.time_ < var_247_11 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_11) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_11 + var_247_16 and arg_244_1.time_ < var_247_11 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1103403067 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1103403067
		arg_250_1.duration_ = 2.9

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1103403068(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.25

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[690].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(1103403067)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 10 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 10)

				if (10 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 10)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")

						arg_250_1:RecordAudio("1103403067", var_253_6)
						arg_250_1:RecordAudio("1103403067", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403067", "story_v_side_new_1103403.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1103403068 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1103403068
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1103403069(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0.133333333333333 < arg_254_1.time_ and arg_254_1.time_ <= 0.133333333333333 + arg_257_0 then
				arg_254_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle02", "")
			end

			if 0.325 < arg_254_1.time_ and arg_254_1.time_ <= 0.325 + arg_257_0 then
				arg_254_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_257_2 = 0
			local var_257_3 = 1.325

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1103403068).content)

				arg_254_1.text_.text = var_257_4

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_6 = 53 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 53)

				if (53 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_4) / 53)) > 0 and var_257_3 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_4
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_7 and arg_254_1.time_ < var_257_2 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1103403069 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1103403069
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1103403070(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.4

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1103403069).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 56 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 56)

				if (56 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 56)) > 0 and var_261_0 < var_261_3 then
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
	Play1103403070 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1103403070
		arg_262_1.duration_ = 2.33

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1103403071(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.15

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[690].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:GetWordFromCfg(1103403070)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")

						arg_262_1:RecordAudio("1103403070", var_265_6)
						arg_262_1:RecordAudio("1103403070", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403070", "story_v_side_new_1103403.awb")
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

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(2, 0, 2)
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1103403071 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1103403071
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1103403072(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0.166666666666667 < arg_266_1.time_ and arg_266_1.time_ <= 0.166666666666667 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run02", "")
			end

			if 0.166666666666667 < arg_266_1.time_ and arg_266_1.time_ <= 0.166666666666667 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_birthday3", "se_story_birthday3_motorcycle", "")
			end

			local var_269_2 = 0
			local var_269_3 = 1.35

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1103403071).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 54 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 54)

				if (54 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 54)) > 0 and var_269_3 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_7 and arg_266_1.time_ < var_269_2 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1103403072 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1103403072
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1103403073(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 1.375

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(1103403072).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 55 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 55)

				if (55 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 55)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1103403073 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1103403073
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1103403074(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.4

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
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

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1103403073).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 16 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 16)

				if (16 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 16)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1103403074 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1103403074
		arg_278_1.duration_ = 2

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1103403075(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1034ui_story = arg_278_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).z)
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles = arg_278_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_278_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1034ui_story"].transform.position).z)
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1034ui_story"].transform.localEulerAngles = arg_278_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1034ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1034ui_story == nil then
				arg_278_1.var_.characterEffect1034ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1034ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1034ui_story then
				arg_278_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_281_4 = 0
			local var_281_5 = 0.125

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(1103403074)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 5 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 5)

				if (5 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 5)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")

						arg_278_1:RecordAudio("1103403074", var_281_11)
						arg_278_1:RecordAudio("1103403074", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403074", "story_v_side_new_1103403.awb")
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1103403075 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1103403075
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1103403076(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_9000

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1034ui_story = arg_282_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).z)
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles = arg_282_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1034ui_story"].transform.position).z)
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1034ui_story"].transform.localEulerAngles = arg_282_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1034ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1034ui_story == nil then
				arg_282_1.var_.characterEffect1034ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect1034ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_2)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1034ui_story then
				arg_282_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				local var_285_3 = arg_282_1.var_.effect6556774563453453123156162165165151

				if not arg_282_1.var_.effect6556774563453453123156162165165151 then
					var_285_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_285_3.name = "123156162165165151"
					arg_282_1.var_.effect6556774563453453123156162165165151 = var_285_3
				else
					var_285_3.transform:SetParent(var_285_9000)
				end

				var_285_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_285_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_285_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_285_6 = var_285_3.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_285_0, iter_285_1 in ipairs((var_285_6:ToTable())) do
					iter_285_1.transform.localScale = Vector3.New(iter_285_1.transform.localScale.x / var_285_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_285_6 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_285_1.transform.localScale.y / var_285_5, iter_285_1.transform.localScale.z)
				end
			end

			if 0.034000001847744 < arg_282_1.time_ and arg_282_1.time_ <= 0.034000001847744 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_285_9 = 0
			local var_285_10 = 1.45

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_11 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1103403075).content)

				arg_282_1.text_.text = var_285_11

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_13 = 58 <= 0 and var_285_10 or var_285_10 * (utf8.len(var_285_11) / 58)

				if (58 <= 0 and var_285_10 or var_285_10 * (utf8.len(var_285_11) / 58)) > 0 and var_285_10 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_9 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_9
					end
				end

				arg_282_1.text_.text = var_285_11
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_10, arg_282_1.talkMaxDuration)

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_9) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_9 + var_285_14 and arg_282_1.time_ < var_285_9 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1103403076 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1103403076
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1103403077(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0.133333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 0.133333333333333 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_289_1 = 0
			local var_289_2 = 1.4

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1103403076).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 56 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 56)

				if (56 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 56)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1103403077 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1103403077
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1103403078(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 1.2

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1103403077).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 48 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 48)

				if (48 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 48)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1103403078 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1103403078
		arg_294_1.duration_ = 8

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1103403079(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if arg_294_1.bgs_.I05a == nil then
				local var_297_0 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_297_0.name = "I05a"
				var_297_0.transform.parent = arg_294_1.stage_.transform
				var_297_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_.I05a = var_297_0
			end

			if 1 < arg_294_1.time_ and arg_294_1.time_ <= 1 + arg_297_0 then
				local var_297_1 = arg_294_1.bgs_.I05a

				arg_294_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_2 = var_297_1:GetComponent("SpriteRenderer")

				if var_297_2 and var_297_2.sprite then
					local var_297_3 = 2 * (var_297_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_1.transform.localScale = Vector3.New(var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "I05a" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_4 = 3

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			if arg_294_1.time_ >= var_297_4 + 0.3 and arg_294_1.time_ < var_297_4 + 0.3 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end

			local var_297_5 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_6 = 1

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_6 then
				local var_297_7 = Color.New(0, 0, 0)

				var_297_7.a = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_5) / var_297_6)
				arg_294_1.mask_.color = var_297_7
			end

			if arg_294_1.time_ >= var_297_5 + var_297_6 and arg_294_1.time_ < var_297_5 + var_297_6 + arg_297_0 then
				local var_297_8 = Color.New(0, 0, 0)

				var_297_8.a = 1
				arg_294_1.mask_.color = var_297_8
			end

			local var_297_9 = 1

			if 1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_10 = 2

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_10 then
				local var_297_11 = Color.New(0, 0, 0)

				var_297_11.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_9) / var_297_10)
				arg_294_1.mask_.color = var_297_11
			end

			if arg_294_1.time_ >= var_297_9 + var_297_10 and arg_294_1.time_ < var_297_9 + var_297_10 + arg_297_0 then
				local var_297_12 = Color.New(0, 0, 0)

				arg_294_1.mask_.enabled = false
				var_297_12.a = 0
				arg_294_1.mask_.color = var_297_12
			end

			if 1 < arg_294_1.time_ and arg_294_1.time_ <= 1 + arg_297_0 then
				if arg_294_1.var_.effect6556774563453453123156162165165151 then
					Object.Destroy(arg_294_1.var_.effect6556774563453453123156162165165151)

					arg_294_1.var_.effect6556774563453453123156162165165151 = nil
				end
			end

			if 0.1 < arg_294_1.time_ and arg_294_1.time_ <= 0.1 + arg_297_0 then
				arg_294_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0.766666666666667 < arg_294_1.time_ and arg_294_1.time_ <= 0.766666666666667 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_16 = 3
			local var_297_17 = 0.15

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_18 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_18:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_19 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(1103403078).content)

				arg_294_1.text_.text = var_297_19

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_21 = 6 <= 0 and var_297_17 or var_297_17 * (utf8.len(var_297_19) / 6)

				if (6 <= 0 and var_297_17 or var_297_17 * (utf8.len(var_297_19) / 6)) > 0 and var_297_17 < var_297_21 then
					arg_294_1.talkMaxDuration = var_297_21
					var_297_16 = var_297_16 + 0.3

					if var_297_21 + var_297_16 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_21 + var_297_16
					end
				end

				arg_294_1.text_.text = var_297_19
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_22 = var_297_16 + 0.3
			local var_297_23 = math.max(var_297_17, arg_294_1.talkMaxDuration)

			if var_297_16 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_22 + var_297_23 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_22) / var_297_23

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_22 + var_297_23 and arg_294_1.time_ < var_297_22 + var_297_23 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1103403079 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1103403079
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1103403080(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.15

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1103403079).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 6 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 6)

				if (6 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 6)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1103403080 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1103403080
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1103403081(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.6

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_1 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(1103403080).content)

				arg_304_1.text_.text = var_307_1

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_3 = 64 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 64)

				if (64 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 64)) > 0 and var_307_0 < var_307_3 then
					arg_304_1.talkMaxDuration = var_307_3

					if var_307_3 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_3 + 0
					end
				end

				arg_304_1.text_.text = var_307_1
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_4 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_4

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1103403081 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1103403081
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1103403082(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0.1 < arg_308_1.time_ and arg_308_1.time_ <= 0.1 + arg_311_0 then
				arg_308_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			local var_311_1 = 0
			local var_311_2 = 0.925

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1103403081).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 37 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 37)

				if (37 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 37)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1103403082 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1103403082
		arg_312_1.duration_ = 2.87

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1103403083(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1034ui_story = arg_312_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).z)
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles = arg_312_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_312_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1034ui_story"].transform.position).z)
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1034ui_story"].transform.localEulerAngles = arg_312_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1034ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1034ui_story == nil then
				arg_312_1.var_.characterEffect1034ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1034ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1034ui_story then
				arg_312_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0.866666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 0.866666666666667 + arg_315_0 then
				arg_312_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			if 0.866666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 0.866666666666667 + arg_315_0 then
				arg_312_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_315_4 = 0
			local var_315_5 = 0.15

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(1103403082)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 6 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 6)

				if (6 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 6)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")

						arg_312_1:RecordAudio("1103403082", var_315_11)
						arg_312_1:RecordAudio("1103403082", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403082", "story_v_side_new_1103403.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1103403083 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1103403083
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1103403084(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1034ui_story"]) and arg_316_1.var_.characterEffect1034ui_story == nil then
				arg_316_1.var_.characterEffect1034ui_story = arg_316_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1034ui_story"]) then
				if arg_316_1.var_.characterEffect1034ui_story and not isNil(arg_316_1.actors_["1034ui_story"]) then
					arg_316_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1034ui_story"]) and arg_316_1.var_.characterEffect1034ui_story then
				arg_316_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.525

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1103403083).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 21)

				if (21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 21)) > 0 and var_319_2 < var_319_5 then
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
	Play1103403084 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1103403084
		arg_320_1.duration_ = 4.33

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1103403085(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1034ui_story"]) and arg_320_1.var_.characterEffect1034ui_story == nil then
				arg_320_1.var_.characterEffect1034ui_story = arg_320_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1034ui_story"]) then
				if arg_320_1.var_.characterEffect1034ui_story and not isNil(arg_320_1.actors_["1034ui_story"]) then
					arg_320_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1034ui_story"]) and arg_320_1.var_.characterEffect1034ui_story then
				arg_320_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_323_2 = 0
			local var_323_3 = 0.475

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_2 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_4 = arg_320_1:GetWordFromCfg(1103403084)
				local var_323_5 = arg_320_1:FormatText(var_323_4.content)

				arg_320_1.text_.text = var_323_5

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_7 = 19 <= 0 and var_323_3 or var_323_3 * (utf8.len(var_323_5) / 19)

				if (19 <= 0 and var_323_3 or var_323_3 * (utf8.len(var_323_5) / 19)) > 0 and var_323_3 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_2 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_2
					end
				end

				arg_320_1.text_.text = var_323_5
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb") / 1000

					if var_323_8 + var_323_2 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_2
					end

					if var_323_4.prefab_name ~= "" and arg_320_1.actors_[var_323_4.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_4.prefab_name].transform, "story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")

						arg_320_1:RecordAudio("1103403084", var_323_9)
						arg_320_1:RecordAudio("1103403084", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403084", "story_v_side_new_1103403.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_3, arg_320_1.talkMaxDuration)

			if var_323_2 <= arg_320_1.time_ and arg_320_1.time_ < var_323_2 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_2) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_2 + var_323_10 and arg_320_1.time_ < var_323_2 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1103403085 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1103403085
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1103403086(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1034ui_story"]) and arg_324_1.var_.characterEffect1034ui_story == nil then
				arg_324_1.var_.characterEffect1034ui_story = arg_324_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1034ui_story"]) then
				if arg_324_1.var_.characterEffect1034ui_story and not isNil(arg_324_1.actors_["1034ui_story"]) then
					arg_324_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1034ui_story"]) and arg_324_1.var_.characterEffect1034ui_story then
				arg_324_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_327_1 = 0
			local var_327_2 = 0.125

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(1103403085).content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 5 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 5)

				if (5 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 5)) > 0 and var_327_2 < var_327_5 then
					arg_324_1.talkMaxDuration = var_327_5

					if var_327_5 + var_327_1 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + var_327_1
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_6 = math.max(var_327_2, arg_324_1.talkMaxDuration)

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_6 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_1) / var_327_6

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_1 + var_327_6 and arg_324_1.time_ < var_327_1 + var_327_6 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1103403086 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1103403086
		arg_328_1.duration_ = 5.03

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1103403087(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1034ui_story"]) and arg_328_1.var_.characterEffect1034ui_story == nil then
				arg_328_1.var_.characterEffect1034ui_story = arg_328_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1034ui_story"]) then
				if arg_328_1.var_.characterEffect1034ui_story and not isNil(arg_328_1.actors_["1034ui_story"]) then
					arg_328_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1034ui_story"]) and arg_328_1.var_.characterEffect1034ui_story then
				arg_328_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_331_2 = 0
			local var_331_3 = 0.675

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_4 = arg_328_1:GetWordFromCfg(1103403086)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 27 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 27)

				if (27 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 27)) > 0 and var_331_3 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb") / 1000

					if var_331_8 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_2
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")

						arg_328_1:RecordAudio("1103403086", var_331_9)
						arg_328_1:RecordAudio("1103403086", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403086", "story_v_side_new_1103403.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_10 and arg_328_1.time_ < var_331_2 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1103403087 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1103403087
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1103403088(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1034ui_story"]) and arg_332_1.var_.characterEffect1034ui_story == nil then
				arg_332_1.var_.characterEffect1034ui_story = arg_332_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1034ui_story"]) then
				if arg_332_1.var_.characterEffect1034ui_story and not isNil(arg_332_1.actors_["1034ui_story"]) then
					arg_332_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1034ui_story"]) and arg_332_1.var_.characterEffect1034ui_story then
				arg_332_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_335_1 = 0
			local var_335_2 = 0.4

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1103403087).content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 16 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 16)

				if (16 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 16)) > 0 and var_335_2 < var_335_5 then
					arg_332_1.talkMaxDuration = var_335_5

					if var_335_5 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_6 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_6 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_6

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_6 and arg_332_1.time_ < var_335_1 + var_335_6 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1103403088 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1103403088
		arg_336_1.duration_ = 3.87

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1103403089(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1034ui_story"]) and arg_336_1.var_.characterEffect1034ui_story == nil then
				arg_336_1.var_.characterEffect1034ui_story = arg_336_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1034ui_story"]) then
				if arg_336_1.var_.characterEffect1034ui_story and not isNil(arg_336_1.actors_["1034ui_story"]) then
					arg_336_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1034ui_story"]) and arg_336_1.var_.characterEffect1034ui_story then
				arg_336_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_339_2 = 0
			local var_339_3 = 0.475

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_4 = arg_336_1:GetWordFromCfg(1103403088)
				local var_339_5 = arg_336_1:FormatText(var_339_4.content)

				arg_336_1.text_.text = var_339_5

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 19 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 19)

				if (19 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 19)) > 0 and var_339_3 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_5
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb") / 1000

					if var_339_8 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_2
					end

					if var_339_4.prefab_name ~= "" and arg_336_1.actors_[var_339_4.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_4.prefab_name].transform, "story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")

						arg_336_1:RecordAudio("1103403088", var_339_9)
						arg_336_1:RecordAudio("1103403088", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403088", "story_v_side_new_1103403.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_10 and arg_336_1.time_ < var_339_2 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1103403089 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1103403089
		arg_340_1.duration_ = 5.07

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1103403090(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_0 = 0
			local var_343_1 = 0.575

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(1103403089)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 23 <= 0 and var_343_1 or var_343_1 * (utf8.len(var_343_3) / 23)

				if (23 <= 0 and var_343_1 or var_343_1 * (utf8.len(var_343_3) / 23)) > 0 and var_343_1 < var_343_5 then
					arg_340_1.talkMaxDuration = var_343_5

					if var_343_5 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb") ~= 0 then
					local var_343_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb") / 1000

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end

					if var_343_2.prefab_name ~= "" and arg_340_1.actors_[var_343_2.prefab_name] ~= nil then
						local var_343_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_2.prefab_name].transform, "story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")

						arg_340_1:RecordAudio("1103403089", var_343_7)
						arg_340_1:RecordAudio("1103403089", var_343_7)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403089", "story_v_side_new_1103403.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_8 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_8 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_8

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_8 and arg_340_1.time_ < var_343_0 + var_343_8 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1103403090 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1103403090
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1103403091(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1034ui_story"]) and arg_344_1.var_.characterEffect1034ui_story == nil then
				arg_344_1.var_.characterEffect1034ui_story = arg_344_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1034ui_story"]) then
				if arg_344_1.var_.characterEffect1034ui_story and not isNil(arg_344_1.actors_["1034ui_story"]) then
					arg_344_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1034ui_story"]) and arg_344_1.var_.characterEffect1034ui_story then
				arg_344_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_347_1 = 0
			local var_347_2 = 0.625

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(1103403090).content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 25 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 25)

				if (25 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_3) / 25)) > 0 and var_347_2 < var_347_5 then
					arg_344_1.talkMaxDuration = var_347_5

					if var_347_5 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_6 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_6 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_6

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_6 and arg_344_1.time_ < var_347_1 + var_347_6 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1103403091 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1103403091
		arg_348_1.duration_ = 2.63

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1103403092(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1034ui_story"]) and arg_348_1.var_.characterEffect1034ui_story == nil then
				arg_348_1.var_.characterEffect1034ui_story = arg_348_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1034ui_story"]) then
				if arg_348_1.var_.characterEffect1034ui_story and not isNil(arg_348_1.actors_["1034ui_story"]) then
					arg_348_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1034ui_story"]) and arg_348_1.var_.characterEffect1034ui_story then
				arg_348_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_351_2 = 0
			local var_351_3 = 0.225

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_2 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_4 = arg_348_1:GetWordFromCfg(1103403091)
				local var_351_5 = arg_348_1:FormatText(var_351_4.content)

				arg_348_1.text_.text = var_351_5

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_7 = 9 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_5) / 9)

				if (9 <= 0 and var_351_3 or var_351_3 * (utf8.len(var_351_5) / 9)) > 0 and var_351_3 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_2
					end
				end

				arg_348_1.text_.text = var_351_5
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb") / 1000

					if var_351_8 + var_351_2 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_2
					end

					if var_351_4.prefab_name ~= "" and arg_348_1.actors_[var_351_4.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_4.prefab_name].transform, "story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")

						arg_348_1:RecordAudio("1103403091", var_351_9)
						arg_348_1:RecordAudio("1103403091", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403091", "story_v_side_new_1103403.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_3, arg_348_1.talkMaxDuration)

			if var_351_2 <= arg_348_1.time_ and arg_348_1.time_ < var_351_2 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_2) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_2 + var_351_10 and arg_348_1.time_ < var_351_2 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1103403092 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1103403092
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1103403093(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1034ui_story"]) and arg_352_1.var_.characterEffect1034ui_story == nil then
				arg_352_1.var_.characterEffect1034ui_story = arg_352_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1034ui_story"]) then
				if arg_352_1.var_.characterEffect1034ui_story and not isNil(arg_352_1.actors_["1034ui_story"]) then
					arg_352_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1034ui_story"]) and arg_352_1.var_.characterEffect1034ui_story then
				arg_352_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_355_1 = 0
			local var_355_2 = 0.1

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(1103403092).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 4 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 4)

				if (4 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 4)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1103403093 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1103403093
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1103403094(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_359_0 = 0
			local var_359_1 = 0.95

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_2 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1103403093).content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 38 <= 0 and var_359_1 or var_359_1 * (utf8.len(var_359_2) / 38)

				if (38 <= 0 and var_359_1 or var_359_1 * (utf8.len(var_359_2) / 38)) > 0 and var_359_1 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_5 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_5 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_5

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_5 and arg_356_1.time_ < var_359_0 + var_359_5 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1103403094 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1103403094
		arg_360_1.duration_ = 5.53

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1103403095(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1034ui_story"]) and arg_360_1.var_.characterEffect1034ui_story == nil then
				arg_360_1.var_.characterEffect1034ui_story = arg_360_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1034ui_story"]) then
				if arg_360_1.var_.characterEffect1034ui_story and not isNil(arg_360_1.actors_["1034ui_story"]) then
					arg_360_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1034ui_story"]) and arg_360_1.var_.characterEffect1034ui_story then
				arg_360_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_363_2 = 0
			local var_363_3 = 0.65

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_2 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_4 = arg_360_1:GetWordFromCfg(1103403094)
				local var_363_5 = arg_360_1:FormatText(var_363_4.content)

				arg_360_1.text_.text = var_363_5

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_7 = 26 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 26)

				if (26 <= 0 and var_363_3 or var_363_3 * (utf8.len(var_363_5) / 26)) > 0 and var_363_3 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_2
					end
				end

				arg_360_1.text_.text = var_363_5
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb") / 1000

					if var_363_8 + var_363_2 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_2
					end

					if var_363_4.prefab_name ~= "" and arg_360_1.actors_[var_363_4.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_4.prefab_name].transform, "story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")

						arg_360_1:RecordAudio("1103403094", var_363_9)
						arg_360_1:RecordAudio("1103403094", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403094", "story_v_side_new_1103403.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_3, arg_360_1.talkMaxDuration)

			if var_363_2 <= arg_360_1.time_ and arg_360_1.time_ < var_363_2 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_2) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_2 + var_363_10 and arg_360_1.time_ < var_363_2 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1103403095 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1103403095
		arg_364_1.duration_ = 2.3

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1103403096(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_367_0 = 0
			local var_367_1 = 0.275

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(1103403095)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 11 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 11)

				if (11 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 11)) > 0 and var_367_1 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb") ~= 0 then
					local var_367_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb") / 1000

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end

					if var_367_2.prefab_name ~= "" and arg_364_1.actors_[var_367_2.prefab_name] ~= nil then
						local var_367_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_2.prefab_name].transform, "story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")

						arg_364_1:RecordAudio("1103403095", var_367_7)
						arg_364_1:RecordAudio("1103403095", var_367_7)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403095", "story_v_side_new_1103403.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1103403096 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1103403096
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1103403097(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1034ui_story"]) and arg_368_1.var_.characterEffect1034ui_story == nil then
				arg_368_1.var_.characterEffect1034ui_story = arg_368_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1034ui_story"]) then
				if arg_368_1.var_.characterEffect1034ui_story and not isNil(arg_368_1.actors_["1034ui_story"]) then
					arg_368_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_0)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1034ui_story"]) and arg_368_1.var_.characterEffect1034ui_story then
				arg_368_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_371_1 = 0
			local var_371_2 = 1.075

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(1103403096).content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 43 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 43)

				if (43 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 43)) > 0 and var_371_2 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_6 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_6 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_6

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_6 and arg_368_1.time_ < var_371_1 + var_371_6 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1103403097 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1103403097
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"

			SetActive(arg_372_1.choicesGo_, true)

			for iter_373_0, iter_373_1 in ipairs(arg_372_1.choices_) do
				SetActive(iter_373_1.go, iter_373_0 <= 2)
			end

			arg_372_1.choices_[1].txt.text = arg_372_1:FormatText(StoryChoiceCfg[1459].name)
			arg_372_1.choices_[2].txt.text = arg_372_1:FormatText(StoryChoiceCfg[1460].name)
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1103403098(arg_372_1)
			end

			if arg_374_0 == 2 then
				arg_372_0:Play1103403101(arg_372_1)
			end

			arg_372_1:RecordChoiceLog(1103403097, 1459, 1460)
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_375_0 = 0

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			if arg_372_1.time_ >= var_375_0 + 2 and arg_372_1.time_ < var_375_0 + 2 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1103403098 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1103403098
		arg_376_1.duration_ = 2.67

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1103403099(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) and arg_376_1.var_.characterEffect1034ui_story == nil then
				arg_376_1.var_.characterEffect1034ui_story = arg_376_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) then
				if arg_376_1.var_.characterEffect1034ui_story and not isNil(arg_376_1.actors_["1034ui_story"]) then
					arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1034ui_story"]) and arg_376_1.var_.characterEffect1034ui_story then
				arg_376_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_379_2 = 0
			local var_379_3 = 0.25

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(1103403098)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 10 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 10)

				if (10 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 10)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")

						arg_376_1:RecordAudio("1103403098", var_379_9)
						arg_376_1:RecordAudio("1103403098", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403098", "story_v_side_new_1103403.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1103403099 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1103403099
		arg_380_1.duration_ = 5.17

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1103403100(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.575

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:GetWordFromCfg(1103403099)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 23 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 23)

				if (23 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 23)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")

						arg_380_1:RecordAudio("1103403099", var_383_6)
						arg_380_1:RecordAudio("1103403099", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403099", "story_v_side_new_1103403.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1103403100 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1103403100
		arg_384_1.duration_ = 5.27

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1103403105(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_387_0 = 0
			local var_387_1 = 0.575

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_2 = arg_384_1:GetWordFromCfg(1103403100)
				local var_387_3 = arg_384_1:FormatText(var_387_2.content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 23 <= 0 and var_387_1 or var_387_1 * (utf8.len(var_387_3) / 23)

				if (23 <= 0 and var_387_1 or var_387_1 * (utf8.len(var_387_3) / 23)) > 0 and var_387_1 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb") ~= 0 then
					local var_387_6 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb") / 1000

					if var_387_6 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_0
					end

					if var_387_2.prefab_name ~= "" and arg_384_1.actors_[var_387_2.prefab_name] ~= nil then
						local var_387_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_2.prefab_name].transform, "story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")

						arg_384_1:RecordAudio("1103403100", var_387_7)
						arg_384_1:RecordAudio("1103403100", var_387_7)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403100", "story_v_side_new_1103403.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_8 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_8 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_8

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_8 and arg_384_1.time_ < var_387_0 + var_387_8 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1103403105 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1103403105
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1103403106(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1034ui_story"]) and arg_388_1.var_.characterEffect1034ui_story == nil then
				arg_388_1.var_.characterEffect1034ui_story = arg_388_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1034ui_story"]) then
				if arg_388_1.var_.characterEffect1034ui_story and not isNil(arg_388_1.actors_["1034ui_story"]) then
					arg_388_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1034ui_story"]) and arg_388_1.var_.characterEffect1034ui_story then
				arg_388_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.200000002980232 < arg_388_1.time_ and arg_388_1.time_ <= 0.200000002980232 + arg_391_0 then
				arg_388_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot", "")
			end

			local var_391_2 = 0
			local var_391_3 = 0.625

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_2 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_4 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(1103403105).content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_6 = 25 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_4) / 25)

				if (25 <= 0 and var_391_3 or var_391_3 * (utf8.len(var_391_4) / 25)) > 0 and var_391_3 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_2 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_2
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_3, arg_388_1.talkMaxDuration)

			if var_391_2 <= arg_388_1.time_ and arg_388_1.time_ < var_391_2 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_2) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_2 + var_391_7 and arg_388_1.time_ < var_391_2 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1103403106 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1103403106
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1103403107(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 1.025

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, false)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(1103403106).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 41 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 41)

				if (41 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 41)) > 0 and var_395_0 < var_395_3 then
					arg_392_1.talkMaxDuration = var_395_3

					if var_395_3 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_3 + 0
					end
				end

				arg_392_1.text_.text = var_395_1
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_4 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_4

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1103403107 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1103403107
		arg_396_1.duration_ = 3.7

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
			arg_396_1.auto_ = false
		end

		function arg_396_1.playNext_(arg_398_0)
			arg_396_1.onStoryFinished_()
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) and arg_396_1.var_.characterEffect1034ui_story == nil then
				arg_396_1.var_.characterEffect1034ui_story = arg_396_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) then
				if arg_396_1.var_.characterEffect1034ui_story and not isNil(arg_396_1.actors_["1034ui_story"]) then
					arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1034ui_story"]) and arg_396_1.var_.characterEffect1034ui_story then
				arg_396_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_399_2 = 0
			local var_399_3 = 0.225

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_2 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_4 = arg_396_1:GetWordFromCfg(1103403107)
				local var_399_5 = arg_396_1:FormatText(var_399_4.content)

				arg_396_1.text_.text = var_399_5

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_7 = 9 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 9)

				if (9 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 9)) > 0 and var_399_3 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_2
					end
				end

				arg_396_1.text_.text = var_399_5
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb") / 1000

					if var_399_8 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_2
					end

					if var_399_4.prefab_name ~= "" and arg_396_1.actors_[var_399_4.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_4.prefab_name].transform, "story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")

						arg_396_1:RecordAudio("1103403107", var_399_9)
						arg_396_1:RecordAudio("1103403107", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403107", "story_v_side_new_1103403.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_3, arg_396_1.talkMaxDuration)

			if var_399_2 <= arg_396_1.time_ and arg_396_1.time_ < var_399_2 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_2) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_2 + var_399_10 and arg_396_1.time_ < var_399_2 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1103403101 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1103403101
		arg_400_1.duration_ = 4.37

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1103403102(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if arg_400_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_403_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_400_1.stage_.transform)

				var_403_0.name = "1034ui_story"
				var_403_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.actors_["1034ui_story"] = var_403_0

				local var_403_1 = var_403_0:GetComponentInChildren(typeof(CharacterEffect))

				var_403_1.enabled = true

				local var_403_2 = GameObjectTools.GetOrAddComponent(var_403_0, typeof(DynamicBoneHelper))

				if var_403_2 then
					var_403_2:EnableDynamicBone(false)
				end

				arg_400_1:ShowWeapon(var_403_1.transform, false)

				arg_400_1.var_["1034ui_story" .. "Animator"] = var_403_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_400_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_400_1.var_["1034ui_story" .. "LipSync"] = var_403_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_403_3 = "1034ui_story"

			if arg_400_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_403_4 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_400_1.stage_.transform)

				var_403_4.name = var_403_3
				var_403_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.actors_[var_403_3] = var_403_4

				local var_403_5 = var_403_4:GetComponentInChildren(typeof(CharacterEffect))

				var_403_5.enabled = true

				local var_403_6 = GameObjectTools.GetOrAddComponent(var_403_4, typeof(DynamicBoneHelper))

				if var_403_6 then
					var_403_6:EnableDynamicBone(false)
				end

				arg_400_1:ShowWeapon(var_403_5.transform, false)

				arg_400_1.var_[var_403_3 .. "Animator"] = var_403_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_400_1.var_[var_403_3 .. "Animator"].applyRootMotion = true
				arg_400_1.var_[var_403_3 .. "LipSync"] = var_403_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_403_7 = arg_400_1.actors_["1034ui_story"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_7) and arg_400_1.var_.characterEffect1034ui_story == nil then
				arg_400_1.var_.characterEffect1034ui_story = var_403_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_8 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_8 and not isNil(var_403_7) then
				if arg_400_1.var_.characterEffect1034ui_story and not isNil(var_403_7) then
					arg_400_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_8 and arg_400_1.time_ < 0 + var_403_8 + arg_403_0 and not isNil(var_403_7) and arg_400_1.var_.characterEffect1034ui_story then
				arg_400_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_403_10 = 0
			local var_403_11 = 0.45

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_10 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_12 = arg_400_1:GetWordFromCfg(1103403101)
				local var_403_13 = arg_400_1:FormatText(var_403_12.content)

				arg_400_1.text_.text = var_403_13

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_15 = 18 <= 0 and var_403_11 or var_403_11 * (utf8.len(var_403_13) / 18)

				if (18 <= 0 and var_403_11 or var_403_11 * (utf8.len(var_403_13) / 18)) > 0 and var_403_11 < var_403_15 then
					arg_400_1.talkMaxDuration = var_403_15

					if var_403_15 + var_403_10 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_15 + var_403_10
					end
				end

				arg_400_1.text_.text = var_403_13
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb") ~= 0 then
					local var_403_16 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb") / 1000

					if var_403_16 + var_403_10 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_16 + var_403_10
					end

					if var_403_12.prefab_name ~= "" and arg_400_1.actors_[var_403_12.prefab_name] ~= nil then
						local var_403_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_12.prefab_name].transform, "story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")

						arg_400_1:RecordAudio("1103403101", var_403_17)
						arg_400_1:RecordAudio("1103403101", var_403_17)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403101", "story_v_side_new_1103403.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_18 = math.max(var_403_11, arg_400_1.talkMaxDuration)

			if var_403_10 <= arg_400_1.time_ and arg_400_1.time_ < var_403_10 + var_403_18 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_10) / var_403_18

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_10 + var_403_18 and arg_400_1.time_ < var_403_10 + var_403_18 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1103403102 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1103403102
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1103403103(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) and arg_404_1.var_.characterEffect1034ui_story == nil then
				arg_404_1.var_.characterEffect1034ui_story = arg_404_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) then
				if arg_404_1.var_.characterEffect1034ui_story and not isNil(arg_404_1.actors_["1034ui_story"]) then
					arg_404_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_0)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1034ui_story"]) and arg_404_1.var_.characterEffect1034ui_story then
				arg_404_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_407_1 = 0
			local var_407_2 = 0.6

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(1103403102).content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_5 = 24 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_3) / 24)

				if (24 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_3) / 24)) > 0 and var_407_2 < var_407_5 then
					arg_404_1.talkMaxDuration = var_407_5

					if var_407_5 + var_407_1 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + var_407_1
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_6 = math.max(var_407_2, arg_404_1.talkMaxDuration)

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_6 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_1) / var_407_6

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_1 + var_407_6 and arg_404_1.time_ < var_407_1 + var_407_6 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1103403103 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1103403103
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1103403104(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.575

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1103403103).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 23 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 23)

				if (23 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 23)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1103403104 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1103403104
		arg_412_1.duration_ = 6.93

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1103403105(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) and arg_412_1.var_.characterEffect1034ui_story == nil then
				arg_412_1.var_.characterEffect1034ui_story = arg_412_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_0 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) then
				if arg_412_1.var_.characterEffect1034ui_story and not isNil(arg_412_1.actors_["1034ui_story"]) then
					arg_412_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["1034ui_story"]) and arg_412_1.var_.characterEffect1034ui_story then
				arg_412_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_415_2 = 0
			local var_415_3 = 0.9

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_2 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_4 = arg_412_1:GetWordFromCfg(1103403104)
				local var_415_5 = arg_412_1:FormatText(var_415_4.content)

				arg_412_1.text_.text = var_415_5

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_7 = 36 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 36)

				if (36 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 36)) > 0 and var_415_3 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_2
					end
				end

				arg_412_1.text_.text = var_415_5
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb") / 1000

					if var_415_8 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_2
					end

					if var_415_4.prefab_name ~= "" and arg_412_1.actors_[var_415_4.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_4.prefab_name].transform, "story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")

						arg_412_1:RecordAudio("1103403104", var_415_9)
						arg_412_1:RecordAudio("1103403104", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403104", "story_v_side_new_1103403.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_3, arg_412_1.talkMaxDuration)

			if var_415_2 <= arg_412_1.time_ and arg_412_1.time_ < var_415_2 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_2) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_2 + var_415_10 and arg_412_1.time_ < var_415_2 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1103403060 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1103403060
		arg_416_1.duration_ = 3.13

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1103403061(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if arg_416_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_419_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_416_1.stage_.transform)

				var_419_0.name = "1034ui_story"
				var_419_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_416_1.actors_["1034ui_story"] = var_419_0

				local var_419_1 = var_419_0:GetComponentInChildren(typeof(CharacterEffect))

				var_419_1.enabled = true

				local var_419_2 = GameObjectTools.GetOrAddComponent(var_419_0, typeof(DynamicBoneHelper))

				if var_419_2 then
					var_419_2:EnableDynamicBone(false)
				end

				arg_416_1:ShowWeapon(var_419_1.transform, false)

				arg_416_1.var_["1034ui_story" .. "Animator"] = var_419_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_416_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_416_1.var_["1034ui_story" .. "LipSync"] = var_419_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_419_3 = arg_416_1.actors_["1034ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_3) and arg_416_1.var_.characterEffect1034ui_story == nil then
				arg_416_1.var_.characterEffect1034ui_story = var_419_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_4 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 and not isNil(var_419_3) then
				if arg_416_1.var_.characterEffect1034ui_story and not isNil(var_419_3) then
					arg_416_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 and not isNil(var_419_3) and arg_416_1.var_.characterEffect1034ui_story then
				arg_416_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_419_6 = 0
			local var_419_7 = 0.35

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_8 = arg_416_1:GetWordFromCfg(1103403060)
				local var_419_9 = arg_416_1:FormatText(var_419_8.content)

				arg_416_1.text_.text = var_419_9

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 14 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 14)

				if (14 <= 0 and var_419_7 or var_419_7 * (utf8.len(var_419_9) / 14)) > 0 and var_419_7 < var_419_11 then
					arg_416_1.talkMaxDuration = var_419_11

					if var_419_11 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_11 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_9
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb") ~= 0 then
					local var_419_12 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb") / 1000

					if var_419_12 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_12 + var_419_6
					end

					if var_419_8.prefab_name ~= "" and arg_416_1.actors_[var_419_8.prefab_name] ~= nil then
						local var_419_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_8.prefab_name].transform, "story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")

						arg_416_1:RecordAudio("1103403060", var_419_13)
						arg_416_1:RecordAudio("1103403060", var_419_13)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403060", "story_v_side_new_1103403.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_14 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_14 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_14

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_14 and arg_416_1.time_ < var_419_6 + var_419_14 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1103403061 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1103403061
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1103403062(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1034ui_story"]) and arg_420_1.var_.characterEffect1034ui_story == nil then
				arg_420_1.var_.characterEffect1034ui_story = arg_420_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1034ui_story"]) then
				if arg_420_1.var_.characterEffect1034ui_story and not isNil(arg_420_1.actors_["1034ui_story"]) then
					arg_420_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_0)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1034ui_story"]) and arg_420_1.var_.characterEffect1034ui_story then
				arg_420_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_423_1 = 0
			local var_423_2 = 0.7

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_3 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(1103403061).content)

				arg_420_1.text_.text = var_423_3

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 28 <= 0 and var_423_2 or var_423_2 * (utf8.len(var_423_3) / 28)

				if (28 <= 0 and var_423_2 or var_423_2 * (utf8.len(var_423_3) / 28)) > 0 and var_423_2 < var_423_5 then
					arg_420_1.talkMaxDuration = var_423_5

					if var_423_5 + var_423_1 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + var_423_1
					end
				end

				arg_420_1.text_.text = var_423_3
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_6 = math.max(var_423_2, arg_420_1.talkMaxDuration)

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_6 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_1) / var_423_6

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_1 + var_423_6 and arg_420_1.time_ < var_423_1 + var_423_6 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play1103403062 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1103403062
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1103403063(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_427_0 = 0
			local var_427_1 = 0.7

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_2 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(1103403062).content)

				arg_424_1.text_.text = var_427_2

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 28 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_2) / 28)

				if (28 <= 0 and var_427_1 or var_427_1 * (utf8.len(var_427_2) / 28)) > 0 and var_427_1 < var_427_4 then
					arg_424_1.talkMaxDuration = var_427_4

					if var_427_4 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_4 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_2
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_5 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_5 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_5

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_5 and arg_424_1.time_ < var_427_0 + var_427_5 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1103403063 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1103403063
		arg_428_1.duration_ = 3.3

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1103403064(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) and arg_428_1.var_.characterEffect1034ui_story == nil then
				arg_428_1.var_.characterEffect1034ui_story = arg_428_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) then
				if arg_428_1.var_.characterEffect1034ui_story and not isNil(arg_428_1.actors_["1034ui_story"]) then
					arg_428_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1034ui_story"]) and arg_428_1.var_.characterEffect1034ui_story then
				arg_428_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_431_2 = 0
			local var_431_3 = 0.325

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_2 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_4 = arg_428_1:GetWordFromCfg(1103403063)
				local var_431_5 = arg_428_1:FormatText(var_431_4.content)

				arg_428_1.text_.text = var_431_5

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 13 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 13)

				if (13 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 13)) > 0 and var_431_3 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_2
					end
				end

				arg_428_1.text_.text = var_431_5
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb") / 1000

					if var_431_8 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_2
					end

					if var_431_4.prefab_name ~= "" and arg_428_1.actors_[var_431_4.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_4.prefab_name].transform, "story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")

						arg_428_1:RecordAudio("1103403063", var_431_9)
						arg_428_1:RecordAudio("1103403063", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403063", "story_v_side_new_1103403.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_10 = math.max(var_431_3, arg_428_1.talkMaxDuration)

			if var_431_2 <= arg_428_1.time_ and arg_428_1.time_ < var_431_2 + var_431_10 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_2) / var_431_10

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_2 + var_431_10 and arg_428_1.time_ < var_431_2 + var_431_10 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1103403018 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1103403018
		arg_432_1.duration_ = 4.67

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1103403019(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) and arg_432_1.var_.characterEffect1034ui_story == nil then
				arg_432_1.var_.characterEffect1034ui_story = arg_432_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) then
				if arg_432_1.var_.characterEffect1034ui_story and not isNil(arg_432_1.actors_["1034ui_story"]) then
					arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1034ui_story"]) and arg_432_1.var_.characterEffect1034ui_story then
				arg_432_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_435_2 = "1034ui_story"

			if arg_432_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_435_3 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_432_1.stage_.transform)

				var_435_3.name = var_435_2
				var_435_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.actors_[var_435_2] = var_435_3

				local var_435_4 = var_435_3:GetComponentInChildren(typeof(CharacterEffect))

				var_435_4.enabled = true

				local var_435_5 = GameObjectTools.GetOrAddComponent(var_435_3, typeof(DynamicBoneHelper))

				if var_435_5 then
					var_435_5:EnableDynamicBone(false)
				end

				arg_432_1:ShowWeapon(var_435_4.transform, false)

				arg_432_1.var_[var_435_2 .. "Animator"] = var_435_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_432_1.var_[var_435_2 .. "Animator"].applyRootMotion = true
				arg_432_1.var_[var_435_2 .. "LipSync"] = var_435_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426")
			end

			local var_435_6 = "1034ui_story"

			if arg_432_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_435_7 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_432_1.stage_.transform)

				var_435_7.name = var_435_6
				var_435_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.actors_[var_435_6] = var_435_7

				local var_435_8 = var_435_7:GetComponentInChildren(typeof(CharacterEffect))

				var_435_8.enabled = true

				local var_435_9 = GameObjectTools.GetOrAddComponent(var_435_7, typeof(DynamicBoneHelper))

				if var_435_9 then
					var_435_9:EnableDynamicBone(false)
				end

				arg_432_1:ShowWeapon(var_435_8.transform, false)

				arg_432_1.var_[var_435_6 .. "Animator"] = var_435_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_432_1.var_[var_435_6 .. "Animator"].applyRootMotion = true
				arg_432_1.var_[var_435_6 .. "LipSync"] = var_435_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_435_10 = 0
			local var_435_11 = 0.45

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_10 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_12 = arg_432_1:GetWordFromCfg(1103403018)
				local var_435_13 = arg_432_1:FormatText(var_435_12.content)

				arg_432_1.text_.text = var_435_13

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_15 = 18 <= 0 and var_435_11 or var_435_11 * (utf8.len(var_435_13) / 18)

				if (18 <= 0 and var_435_11 or var_435_11 * (utf8.len(var_435_13) / 18)) > 0 and var_435_11 < var_435_15 then
					arg_432_1.talkMaxDuration = var_435_15

					if var_435_15 + var_435_10 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_15 + var_435_10
					end
				end

				arg_432_1.text_.text = var_435_13
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb") ~= 0 then
					local var_435_16 = manager.audio:GetVoiceLength("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb") / 1000

					if var_435_16 + var_435_10 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_16 + var_435_10
					end

					if var_435_12.prefab_name ~= "" and arg_432_1.actors_[var_435_12.prefab_name] ~= nil then
						local var_435_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_12.prefab_name].transform, "story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")

						arg_432_1:RecordAudio("1103403018", var_435_17)
						arg_432_1:RecordAudio("1103403018", var_435_17)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1103403", "1103403018", "story_v_side_new_1103403.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_18 = math.max(var_435_11, arg_432_1.talkMaxDuration)

			if var_435_10 <= arg_432_1.time_ and arg_432_1.time_ < var_435_10 + var_435_18 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_10) / var_435_18

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_10 + var_435_18 and arg_432_1.time_ < var_435_10 + var_435_18 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1103403019 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1103403019
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1103403020(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) and arg_436_1.var_.characterEffect1034ui_story == nil then
				arg_436_1.var_.characterEffect1034ui_story = arg_436_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) then
				if arg_436_1.var_.characterEffect1034ui_story and not isNil(arg_436_1.actors_["1034ui_story"]) then
					arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_0)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1034ui_story"]) and arg_436_1.var_.characterEffect1034ui_story then
				arg_436_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_439_1 = 0
			local var_439_2 = 0.825

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(1103403019).content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 33 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 33)

				if (33 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 33)) > 0 and var_439_2 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_1 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_1
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_6 = math.max(var_439_2, arg_436_1.talkMaxDuration)

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_6 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_1) / var_439_6

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_1 + var_439_6 and arg_436_1.time_ < var_439_1 + var_439_6 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_side_new_1103403.awb"
	}
}
