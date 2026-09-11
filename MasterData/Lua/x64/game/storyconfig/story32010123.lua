return {
	Play320731001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320731001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320731002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST65 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST65")
				var_4_0.name = "ST65"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST65 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST65

				arg_1_1.bgs_.ST65.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST65" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1089ui_story"

			if arg_1_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1089ui_story"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos1089ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_1_1.time_ - 1.86666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_14 and arg_1_1.time_ < 1.86666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1089ui_story"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story == nil then
				arg_1_1.var_.characterEffect1089ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1089ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_16 and arg_1_1.time_ < 1.86666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1089ui_story then
				arg_1_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
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

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

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

			if 1.866666666666 < arg_1_1.time_ and arg_1_1.time_ <= 1.866666666666 + arg_4_0 then
				arg_1_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(320731001).content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 10)

				if (10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 10)) > 0 and var_4_25 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_24 = var_4_24 + 0.3

					if var_4_29 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_24 + 0.3
			local var_4_31 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320731002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320731002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play320731003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1056ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1056ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1056ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1056ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1056ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1056ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -1, -5.75)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1056ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story == nil then
				arg_9_1.var_.characterEffect1056ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1056ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1056ui_story then
				arg_9_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["1089ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1089ui_story == nil then
				arg_9_1.var_.characterEffect1089ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1089ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1089ui_story then
				arg_9_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_12_10 = 0
			local var_12_11 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(320731002).content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 17 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 17)

				if (17 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 17)) > 0 and var_12_11 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_15 and arg_9_1.time_ < var_12_10 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play320731003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320731003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320731004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1089ui_story = arg_13_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).z)
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles = arg_13_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				arg_13_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1089ui_story"].transform.position).z)
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1089ui_story"].transform.localEulerAngles = arg_13_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1089ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1089ui_story == nil then
				arg_13_1.var_.characterEffect1089ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1089ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1089ui_story then
				arg_13_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_2")
			end

			local var_16_4 = arg_13_1.actors_["1056ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1056ui_story == nil then
				arg_13_1.var_.characterEffect1056ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_5 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and not isNil(var_16_4) then
				if arg_13_1.var_.characterEffect1056ui_story and not isNil(var_16_4) then
					arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_5)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect1056ui_story then
				arg_13_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_16_6 = 0
			local var_16_7 = 0.475

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(320731003).content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 19 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_8) / 19)

				if (19 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_8) / 19)) > 0 and var_16_7 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_11 and arg_13_1.time_ < var_16_6 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play320731004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320731004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320731005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1089ui_story"]) and arg_17_1.var_.characterEffect1089ui_story == nil then
				arg_17_1.var_.characterEffect1089ui_story = arg_17_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1089ui_story"]) then
				if arg_17_1.var_.characterEffect1089ui_story and not isNil(arg_17_1.actors_["1089ui_story"]) then
					arg_17_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1089ui_story"]) and arg_17_1.var_.characterEffect1089ui_story then
				arg_17_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(320731004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 19 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 19)

				if (19 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 19)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320731005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320731005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play320731006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1089ui_story = arg_21_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).z)
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles = arg_21_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1089ui_story"].transform.position).z)
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1089ui_story"].transform.localEulerAngles = arg_21_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1089ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1089ui_story == nil then
				arg_21_1.var_.characterEffect1089ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1089ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_2)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1089ui_story then
				arg_21_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_24_3 = arg_21_1.actors_["1056ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1056ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, 100, 0)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1056ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1056ui_story == nil then
				arg_21_1.var_.characterEffect1056ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1056ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_6)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1056ui_story then
				arg_21_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_24_7 = "1020ui_story"

			if arg_21_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_24_8 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_21_1.stage_.transform)

				var_24_8.name = var_24_7
				var_24_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_7] = var_24_8

				local var_24_9 = var_24_8:GetComponentInChildren(typeof(CharacterEffect))

				var_24_9.enabled = true

				local var_24_10 = GameObjectTools.GetOrAddComponent(var_24_8, typeof(DynamicBoneHelper))

				if var_24_10 then
					var_24_10:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_9.transform, false)

				arg_21_1.var_[var_24_7 .. "Animator"] = var_24_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_7 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_7 .. "LipSync"] = var_24_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_11 = arg_21_1.actors_["1020ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1020ui_story = var_24_11.localPosition
			end

			local var_24_12 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_12 then
				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_21_1.time_ - 0) / var_24_12)
				var_24_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_11.position).x, (manager.ui.mainCamera.transform.position - var_24_11.position).y, (manager.ui.mainCamera.transform.position - var_24_11.position).z)
				var_24_11.localEulerAngles.z = 0
				var_24_11.localEulerAngles.x = 0
				var_24_11.localEulerAngles = var_24_11.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_12 and arg_21_1.time_ < 0 + var_24_12 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0, -0.85, -6.25)
				var_24_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_11.position).x, (manager.ui.mainCamera.transform.position - var_24_11.position).y, (manager.ui.mainCamera.transform.position - var_24_11.position).z)
				var_24_11.localEulerAngles.z = 0
				var_24_11.localEulerAngles.x = 0
				var_24_11.localEulerAngles = var_24_11.localEulerAngles
			end

			local var_24_13 = arg_21_1.actors_["1020ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_13) and arg_21_1.var_.characterEffect1020ui_story == nil then
				arg_21_1.var_.characterEffect1020ui_story = var_24_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_14 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_14 and not isNil(var_24_13) then
				if arg_21_1.var_.characterEffect1020ui_story and not isNil(var_24_13) then
					arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_14 and arg_21_1.time_ < 0 + var_24_14 + arg_24_0 and not isNil(var_24_13) and arg_21_1.var_.characterEffect1020ui_story then
				arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_24_16 = 0
			local var_24_17 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(320731005).content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 17 <= 0 and var_24_17 or var_24_17 * (utf8.len(var_24_18) / 17)

				if (17 <= 0 and var_24_17 or var_24_17 * (utf8.len(var_24_18) / 17)) > 0 and var_24_17 < var_24_20 then
					arg_21_1.talkMaxDuration = var_24_20

					if var_24_20 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_18
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_21 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_21 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_21

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_21 and arg_21_1.time_ < var_24_16 + var_24_21 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play320731006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320731006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play320731007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_28_0 = 0
			local var_28_1 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_2 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(320731006).content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 20 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_2) / 20)

				if (20 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_2) / 20)) > 0 and var_28_1 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_5 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_5 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_5

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_5 and arg_25_1.time_ < var_28_0 + var_28_5 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320731007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320731007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play320731008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story == nil then
				arg_29_1.var_.characterEffect1020ui_story = arg_29_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) then
				if arg_29_1.var_.characterEffect1020ui_story and not isNil(arg_29_1.actors_["1020ui_story"]) then
					arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story then
				arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.35

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

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(320731007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 14 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 14)

				if (14 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 14)) > 0 and var_32_2 < var_32_5 then
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
	Play320731008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320731008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play320731009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1020ui_story = arg_33_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).z)
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles = arg_33_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_33_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1020ui_story"].transform.position).z)
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1020ui_story"].transform.localEulerAngles = arg_33_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1020ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1020ui_story == nil then
				arg_33_1.var_.characterEffect1020ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1020ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1020ui_story then
				arg_33_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4312")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_4 = 0
			local var_36_5 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(320731008).content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 22 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 22)

				if (22 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 22)) > 0 and var_36_5 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_9 and arg_33_1.time_ < var_36_4 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play320731009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320731009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320731010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1020ui_story = arg_37_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).z)
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles = arg_37_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				arg_37_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1020ui_story"].transform.position).z)
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1020ui_story"].transform.localEulerAngles = arg_37_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1020ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1020ui_story == nil then
				arg_37_1.var_.characterEffect1020ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1020ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1020ui_story then
				arg_37_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_40_3 = arg_37_1.actors_["1089ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1089ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0.7, -1.1, -6.17)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["1089ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1089ui_story == nil then
				arg_37_1.var_.characterEffect1089ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect1089ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1089ui_story then
				arg_37_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_40_8 = 0
			local var_40_9 = 0.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(320731009).content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 13 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_10) / 13)

				if (13 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_10) / 13)) > 0 and var_40_9 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_13 and arg_37_1.time_ < var_40_8 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play320731010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320731010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320731011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1089ui_story"]) and arg_41_1.var_.characterEffect1089ui_story == nil then
				arg_41_1.var_.characterEffect1089ui_story = arg_41_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1089ui_story"]) then
				if arg_41_1.var_.characterEffect1089ui_story and not isNil(arg_41_1.actors_["1089ui_story"]) then
					arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1089ui_story"]) and arg_41_1.var_.characterEffect1089ui_story then
				arg_41_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.4

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

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(320731010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 16)

				if (16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 16)) > 0 and var_44_2 < var_44_5 then
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
	Play320731011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320731011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320731012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1020ui_story = arg_45_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).z)
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles = arg_45_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				arg_45_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1020ui_story"].transform.position).z)
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1020ui_story"].transform.localEulerAngles = arg_45_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1020ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1020ui_story == nil then
				arg_45_1.var_.characterEffect1020ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1020ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1020ui_story then
				arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action12_2")
			end

			local var_48_4 = 0
			local var_48_5 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(320731011).content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 20 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 20)

				if (20 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 20)) > 0 and var_48_5 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_9 and arg_45_1.time_ < var_48_4 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play320731012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320731012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play320731013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) and arg_49_1.var_.characterEffect1020ui_story == nil then
				arg_49_1.var_.characterEffect1020ui_story = arg_49_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) then
				if arg_49_1.var_.characterEffect1020ui_story and not isNil(arg_49_1.actors_["1020ui_story"]) then
					arg_49_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1020ui_story"]) and arg_49_1.var_.characterEffect1020ui_story then
				arg_49_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.25

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

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(320731012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 10 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 10)

				if (10 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 10)) > 0 and var_52_2 < var_52_5 then
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
	Play320731013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320731013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play320731014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) and arg_53_1.var_.characterEffect1020ui_story == nil then
				arg_53_1.var_.characterEffect1020ui_story = arg_53_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) then
				if arg_53_1.var_.characterEffect1020ui_story and not isNil(arg_53_1.actors_["1020ui_story"]) then
					arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1020ui_story"]) and arg_53_1.var_.characterEffect1020ui_story then
				arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_56_2 = 0
			local var_56_3 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(320731013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 9 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 9)

				if (9 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 9)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play320731014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320731014
		arg_57_1.duration_ = 8.27

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play320731015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 3.43333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 3.43333333333333 + arg_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) and arg_57_1.var_.characterEffect1020ui_story == nil then
				arg_57_1.var_.characterEffect1020ui_story = arg_57_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 3.43333333333333 <= arg_57_1.time_ and arg_57_1.time_ < 3.43333333333333 + var_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) then
				if arg_57_1.var_.characterEffect1020ui_story and not isNil(arg_57_1.actors_["1020ui_story"]) then
					arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 3.43333333333333) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 3.43333333333333 + var_60_0 and arg_57_1.time_ < 3.43333333333333 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1020ui_story"]) and arg_57_1.var_.characterEffect1020ui_story then
				arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 1.43333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 1.43333333333333 + arg_60_0 then
				local var_60_1 = arg_57_1.bgs_.ST65

				arg_57_1.bgs_.ST65.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_2 = var_60_1:GetComponent("SpriteRenderer")

				if var_60_2 and var_60_2.sprite then
					local var_60_3 = 2 * (var_60_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_1.transform.localScale = Vector3.New(var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST65" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_5 = 1.43333333333333

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_5 then
				local var_60_6 = Color.New(0, 0, 0)

				var_60_6.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_4) / var_60_5)
				arg_57_1.mask_.color = var_60_6
			end

			if arg_57_1.time_ >= var_60_4 + var_60_5 and arg_57_1.time_ < var_60_4 + var_60_5 + arg_60_0 then
				local var_60_7 = Color.New(0, 0, 0)

				var_60_7.a = 1
				arg_57_1.mask_.color = var_60_7
			end

			local var_60_8 = 1.43333333333333

			if 1.43333333333333 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_9 = 2

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				local var_60_10 = Color.New(0, 0, 0)

				var_60_10.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_8) / var_60_9)
				arg_57_1.mask_.color = var_60_10
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				local var_60_11 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_11.a = 0
				arg_57_1.mask_.color = var_60_11
			end

			local var_60_12 = arg_57_1.actors_["1089ui_story"].transform

			if 1.39933333148559 < arg_57_1.time_ and arg_57_1.time_ <= 1.39933333148559 + arg_60_0 then
				arg_57_1.var_.moveOldPos1089ui_story = var_60_12.localPosition
			end

			local var_60_13 = 0.001

			if 1.39933333148559 <= arg_57_1.time_ and arg_57_1.time_ < 1.39933333148559 + var_60_13 then
				var_60_12.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 1.39933333148559) / var_60_13)
				var_60_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_12.position).x, (manager.ui.mainCamera.transform.position - var_60_12.position).y, (manager.ui.mainCamera.transform.position - var_60_12.position).z)
				var_60_12.localEulerAngles.z = 0
				var_60_12.localEulerAngles.x = 0
				var_60_12.localEulerAngles = var_60_12.localEulerAngles
			end

			if arg_57_1.time_ >= 1.39933333148559 + var_60_13 and arg_57_1.time_ < 1.39933333148559 + var_60_13 + arg_60_0 then
				var_60_12.localPosition = Vector3.New(0, 100, 0)
				var_60_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_12.position).x, (manager.ui.mainCamera.transform.position - var_60_12.position).y, (manager.ui.mainCamera.transform.position - var_60_12.position).z)
				var_60_12.localEulerAngles.z = 0
				var_60_12.localEulerAngles.x = 0
				var_60_12.localEulerAngles = var_60_12.localEulerAngles
			end

			local var_60_14 = arg_57_1.actors_["1020ui_story"].transform

			if 1.39933333148559 < arg_57_1.time_ and arg_57_1.time_ <= 1.39933333148559 + arg_60_0 then
				arg_57_1.var_.moveOldPos1020ui_story = var_60_14.localPosition
			end

			local var_60_15 = 0.001

			if 1.39933333148559 <= arg_57_1.time_ and arg_57_1.time_ < 1.39933333148559 + var_60_15 then
				var_60_14.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 1.39933333148559) / var_60_15)
				var_60_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_14.position).x, (manager.ui.mainCamera.transform.position - var_60_14.position).y, (manager.ui.mainCamera.transform.position - var_60_14.position).z)
				var_60_14.localEulerAngles.z = 0
				var_60_14.localEulerAngles.x = 0
				var_60_14.localEulerAngles = var_60_14.localEulerAngles
			end

			if arg_57_1.time_ >= 1.39933333148559 + var_60_15 and arg_57_1.time_ < 1.39933333148559 + var_60_15 + arg_60_0 then
				var_60_14.localPosition = Vector3.New(0, 100, 0)
				var_60_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_14.position).x, (manager.ui.mainCamera.transform.position - var_60_14.position).y, (manager.ui.mainCamera.transform.position - var_60_14.position).z)
				var_60_14.localEulerAngles.z = 0
				var_60_14.localEulerAngles.x = 0
				var_60_14.localEulerAngles = var_60_14.localEulerAngles
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_16 = 3.26666666666667
			local var_60_17 = 0.45

			if 3.26666666666667 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_18 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_18:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_19 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(320731014).content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 18 <= 0 and var_60_17 or var_60_17 * (utf8.len(var_60_19) / 18)

				if (18 <= 0 and var_60_17 or var_60_17 * (utf8.len(var_60_19) / 18)) > 0 and var_60_17 < var_60_21 then
					arg_57_1.talkMaxDuration = var_60_21
					var_60_16 = var_60_16 + 0.3

					if var_60_21 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_21 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = var_60_16 + 0.3
			local var_60_23 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_22 + var_60_23 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_22) / var_60_23

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_22 + var_60_23 and arg_57_1.time_ < var_60_22 + var_60_23 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.39933333148559,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.39933333148559,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play320731015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 320731015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play320731016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.3

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(320731015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 12 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 12)

				if (12 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 12)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play320731016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 320731016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play320731017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_70_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_67_1.stage_.transform)

				var_70_0.name = "10100ui_story"
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["10100ui_story"] = var_70_0

				local var_70_1 = var_70_0:GetComponentInChildren(typeof(CharacterEffect))

				var_70_1.enabled = true

				local var_70_2 = GameObjectTools.GetOrAddComponent(var_70_0, typeof(DynamicBoneHelper))

				if var_70_2 then
					var_70_2:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_1.transform, false)

				arg_67_1.var_["10100ui_story" .. "Animator"] = var_70_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_67_1.var_["10100ui_story" .. "LipSync"] = var_70_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_3 = arg_67_1.actors_["10100ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10100ui_story = var_70_3.localPosition
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_3.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_67_1.time_ - 0) / var_70_4)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			local var_70_5 = arg_67_1.actors_["10100ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10100ui_story == nil then
				arg_67_1.var_.characterEffect10100ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect10100ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10100ui_story then
				arg_67_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1", "EmotionTimelineAnimator")
			end

			local var_70_8 = 0
			local var_70_9 = 0.475

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_10 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(320731016).content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_12 = 19 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_10) / 19)

				if (19 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_10) / 19)) > 0 and var_70_9 < var_70_12 then
					arg_67_1.talkMaxDuration = var_70_12

					if var_70_12 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_13 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_13 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_13

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_13 and arg_67_1.time_ < var_70_8 + var_70_13 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play320731017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 320731017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play320731018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10100ui_story"]) and arg_71_1.var_.characterEffect10100ui_story == nil then
				arg_71_1.var_.characterEffect10100ui_story = arg_71_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10100ui_story"]) then
				if arg_71_1.var_.characterEffect10100ui_story and not isNil(arg_71_1.actors_["10100ui_story"]) then
					arg_71_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10100ui_story"]) and arg_71_1.var_.characterEffect10100ui_story then
				arg_71_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(320731017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 8 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 8)

				if (8 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 8)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play320731018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 320731018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play320731019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(320731018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 18 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 18)

				if (18 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 18)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play320731019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 320731019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play320731020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10100ui_story = arg_79_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).z)
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles = arg_79_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_79_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10100ui_story"].transform.position).z)
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10100ui_story"].transform.localEulerAngles = arg_79_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10100ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10100ui_story == nil then
				arg_79_1.var_.characterEffect10100ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10100ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10100ui_story then
				arg_79_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_82_4 = 0
			local var_82_5 = 0.65

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(320731019).content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 26 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_6) / 26)

				if (26 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_6) / 26)) > 0 and var_82_5 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_9 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_9 and arg_79_1.time_ < var_82_4 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play320731020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 320731020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play320731021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10100ui_story = arg_83_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).z)
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles = arg_83_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_83_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["10100ui_story"].transform.position).z)
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["10100ui_story"].transform.localEulerAngles = arg_83_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["10100ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10100ui_story == nil then
				arg_83_1.var_.characterEffect10100ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect10100ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10100ui_story then
				arg_83_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_86_3 = arg_83_1.actors_["1056ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1056ui_story = var_86_3.localPosition
			end

			local var_86_4 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				var_86_3.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_83_1.time_ - 0) / var_86_4)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				var_86_3.localPosition = Vector3.New(0.7, -1, -5.75)
				var_86_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_3.position).x, (manager.ui.mainCamera.transform.position - var_86_3.position).y, (manager.ui.mainCamera.transform.position - var_86_3.position).z)
				var_86_3.localEulerAngles.z = 0
				var_86_3.localEulerAngles.x = 0
				var_86_3.localEulerAngles = var_86_3.localEulerAngles
			end

			local var_86_5 = arg_83_1.actors_["1056ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1056ui_story == nil then
				arg_83_1.var_.characterEffect1056ui_story = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 and not isNil(var_86_5) then
				if arg_83_1.var_.characterEffect1056ui_story and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect1056ui_story then
				arg_83_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_86_8 = 0
			local var_86_9 = 0.55

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(320731020).content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 22 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_10) / 22)

				if (22 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_10) / 22)) > 0 and var_86_9 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_13 and arg_83_1.time_ < var_86_8 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play320731021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 320731021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play320731022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1056ui_story"]) and arg_87_1.var_.characterEffect1056ui_story == nil then
				arg_87_1.var_.characterEffect1056ui_story = arg_87_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1056ui_story"]) then
				if arg_87_1.var_.characterEffect1056ui_story and not isNil(arg_87_1.actors_["1056ui_story"]) then
					arg_87_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1056ui_story"]) and arg_87_1.var_.characterEffect1056ui_story then
				arg_87_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(320731021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 18 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 18)

				if (18 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 18)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play320731022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 320731022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play320731023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10100ui_story = arg_91_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).z)
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles = arg_91_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10100ui_story"].transform.position).z)
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10100ui_story"].transform.localEulerAngles = arg_91_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10100ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10100ui_story == nil then
				arg_91_1.var_.characterEffect10100ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10100ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10100ui_story then
				arg_91_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_94_3 = arg_91_1.actors_["1056ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1056ui_story = var_94_3.localPosition
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_4)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(0, 100, 0)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			local var_94_5 = arg_91_1.actors_["1056ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect1056ui_story == nil then
				arg_91_1.var_.characterEffect1056ui_story = var_94_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.characterEffect1056ui_story and not isNil(var_94_5) then
					arg_91_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_6)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect1056ui_story then
				arg_91_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_94_7 = arg_91_1.actors_["1089ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1089ui_story = var_94_7.localPosition
			end

			local var_94_8 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_8 then
				var_94_7.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_91_1.time_ - 0) / var_94_8)
				var_94_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_7.position).x, (manager.ui.mainCamera.transform.position - var_94_7.position).y, (manager.ui.mainCamera.transform.position - var_94_7.position).z)
				var_94_7.localEulerAngles.z = 0
				var_94_7.localEulerAngles.x = 0
				var_94_7.localEulerAngles = var_94_7.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_8 and arg_91_1.time_ < 0 + var_94_8 + arg_94_0 then
				var_94_7.localPosition = Vector3.New(0, -1.1, -6.17)
				var_94_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_7.position).x, (manager.ui.mainCamera.transform.position - var_94_7.position).y, (manager.ui.mainCamera.transform.position - var_94_7.position).z)
				var_94_7.localEulerAngles.z = 0
				var_94_7.localEulerAngles.x = 0
				var_94_7.localEulerAngles = var_94_7.localEulerAngles
			end

			local var_94_9 = arg_91_1.actors_["1089ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1089ui_story == nil then
				arg_91_1.var_.characterEffect1089ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_10 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_10 and not isNil(var_94_9) then
				if arg_91_1.var_.characterEffect1089ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_10 and arg_91_1.time_ < 0 + var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1089ui_story then
				arg_91_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_94_12 = 0
			local var_94_13 = 0.375

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_14 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(320731022).content)

				arg_91_1.text_.text = var_94_14

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_16 = 15 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_14) / 15)

				if (15 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_14) / 15)) > 0 and var_94_13 < var_94_16 then
					arg_91_1.talkMaxDuration = var_94_16

					if var_94_16 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_14
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_17 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_17 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_17

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_17 and arg_91_1.time_ < var_94_12 + var_94_17 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play320731023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 320731023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play320731024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1089ui_story = arg_95_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).z)
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles = arg_95_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1089ui_story"].transform.position).z)
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1089ui_story"].transform.localEulerAngles = arg_95_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1089ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1089ui_story == nil then
				arg_95_1.var_.characterEffect1089ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1089ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1089ui_story then
				arg_95_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_98_3 = arg_95_1.actors_["1020ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1020ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["1020ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1020ui_story == nil then
				arg_95_1.var_.characterEffect1020ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect1020ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1020ui_story then
				arg_95_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_98_8 = 0
			local var_98_9 = 0.55

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(320731023).content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_12 = 22 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_10) / 22)

				if (22 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_10) / 22)) > 0 and var_98_9 < var_98_12 then
					arg_95_1.talkMaxDuration = var_98_12

					if var_98_12 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_13 and arg_95_1.time_ < var_98_8 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play320731024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 320731024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
			arg_99_1.auto_ = false
		end

		function arg_99_1.playNext_(arg_101_0)
			arg_99_1.onStoryFinished_()
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_102_0 = 0
			local var_102_1 = 0.375

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(320731024).content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 15 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_2) / 15)

				if (15 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_2) / 15)) > 0 and var_102_1 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_5 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_5 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_5

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_5 and arg_99_1.time_ < var_102_0 + var_102_5 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST65"
	},
	voices = {}
}
